---
title: "Helm — Templating Network Policy using Helm"
date: 2024-02-04T16:22:35+00:00
slug: helm-templating-network-policy
tags: ["helm", "kubernetes", "devops"]
series: ["kubernetes-in-practice"]
part: 1
short: "Helm Network Policy"
summary: "Helm is very useful to package your application."
medium: "https://bagas-awibowo.medium.com/helm-templating-network-policy-using-helm-783b2f7e401a"
---
Helm is very useful to package your application. It have capability to templating your Kubernetes resources. So you can reuse the same resource for different purpose. Besides it will help you or developer to maintain the resource with simpler structure kind of resource based on Helm best practices or with your own way.

In this part I will try to templating the Network Policy resources by Helm. The first problem is Network Policy can be a complex resource to manage and hard to understand.

To ensure security for your application the Network Policy was very important, you will control the incoming and outgoing traffic from nor to your application. First you need to understand the flow of Network Policy to identify what need to do to ensure your application is secure.

![Network Policy Editor by Cilium](img-01.png)
*Network Policy Editor by Cilium*

The tool that very helpful for me is <https://editor.networkpolicy.io/>. It will help you to generate the Network Policy with your own needs. So why we still need the Helm to templating the Network Policy?

After we applying the Network Policy we still need to maintain the rule that we apply to the cluster. If we apply the complex rule and manage multiple application will hard to maintain. So we can simplify it by using Helm.

Below the manifest of Network Policy that templated using Helm.

networkpolicy.yaml

```yaml
{{- range .Values.networkPolicies }}
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: {{ .name }}
spec:
{{- include "netpol.podSelector" . | indent 2 }}
{{- if .ingress }}
{{- include "netpol.ingress" . | indent 2 }}
{{- end }}
{{- if .egress }}
{{- include "netpol.egress" . | indent 2 }}
{{- end }}
---
{{- end }}
```

Looks simpler than original resource right? By that template Helm can generate multiple Network Policy file by just passing the value that we required to apply the policy. The main key of the Network Policy is Ingress and Egress and the components to control the traffic is:

1.  Outside cluster, later we can define it by name ***cidrs.*** This part will control the traffic coming from nor to outside cluster by IP block subnets.
2.  In Namespace, later we can define it by name ***podSelectors***. This part will control the traffic inside the namespace where the application is deployed. It will control the access between the application within the namespace.
3.  In Cluster, later we can define it by name ***namespaceSelectors***. This part will control the traffic within the cluster, thats why I defined as namespaceSelectors. Because the traffic will be scoped within cluster and can be filtered per-namespace. With namespaceSelectors also we still need to define the specific Pod labels to apply the rule.

All the components of Network Policy will be created through the named template, is simply a template defined inside the file. By default defined inside ***\_helpers.tpl*** on the ***templates*** directory. You can read more detail to understand the Helm flow control here <https://helm.sh/docs/chart_template_guide/control_structures/>

Let’s look into the inside ***\_helpers.tpl***:

1.  Create a function to handle the podSelector

```yaml
{{- define "netpol.podSelector" }}
{{- if .podSelector }}
podSelector:
  {{- range $key, $value := .podSelector }}
  matchLabels:
    {{ $key }}: {{ $value }}
  {{- end }}
{{- else }}
podSelector: {}
{{- end }}
{{- end }}
```

On those part, the template will handle to define which resource that will be applied by the policy. If not defined will set the **podSelector: {}**, it mean the policy applied to all Pod inside the namespace.

2\. Create a function to generate the Ingress and Egress section

```yaml
{{/*
Ingress block
*/}}
{{- define "netpol.ingress" }}
ingress:
- from:
  {{- if .ingress.cidrs }}
    {{- with .ingress }}
    {{- include "netpol.scoped.cidr" (dict "scope" .) | indent 2 }}
    {{- end }}
  {{- end }}

  {{- if .ingress.podSelectors }}
    {{- with .ingress }}
    {{- include "netpol.scoped.podSelector" (dict "scope" .) | indent 2 }}
    {{- end }}
  {{- end }}

  {{- if .ingress.namespaceSelectors }}
    {{- with .ingress }}
    {{- include "netpol.scoped.namespaceSelector" (dict "scope" .) | indent 2 }}
    {{- end }}
  {{- end }}

  {{- if .ingress.ports }}
    {{- with .ingress }}
    {{- include "netpol.scoped.port" (dict "scope" .) | indent 2 }}
    {{- end }}
  {{- end }}
{{- end }}

{{/*
Egress block
*/}}
{{- define "netpol.egress" }}
egress:
- to:
  {{- if .egress.cidrs }}
    {{- with .egress }}
    {{- include "netpol.scoped.cidr" (dict "scope" .) | indent 2 }}
    {{- end }}
  {{- end }}

  {{- if .egress.podSelectors }}
    {{- with .egress }}
    {{- include "netpol.scoped.podSelector" (dict "scope" .) | indent 2 }}
    {{- end }}
  {{- end }}

  {{- if .egress.namespaceSelectors }}
    {{- with .egress }}
    {{- include "netpol.scoped.namespaceSelector" (dict "scope" .) | indent 2 }}
    {{- end }}
  {{- end }}

  {{- if .egress.ports }}
    {{- with .egress }}
    {{- include "netpol.scoped.port" (dict "scope" .) | indent 2 }}
    {{- end }}
  {{- end }}
{{- end }}
```

As I mentioned before, the Network Policy will manage the traffic from (Ingress) nor to (Egress). With the Helm template we can reuse the same function if have same behaviour. For example, we just define single template to handle the filter by CIDR, and we can call inside the Ingress or Egress template.

3\. Create a function to handle filter based on IP Block CIDR

```yaml
{{/*
Generate netpol by IP Block CIDR
*/}}
{{- define "netpol.scoped.cidr" }}
{{- range .scope.cidrs }}
- ipBlock:
    cidr: {{ .ip }}
    {{- if .excepts }}
    except: {{ toYaml .excepts | nindent 6 }}
    {{- end }}
{{- end }}
{{- end }}
```

The example structure to add filter by IP is below:

```yaml
    cidrs:
      - ip: 172.17.0.0/16
        excepts:
        - 172.17.1.0/24
      - ip: 10.0.0.1/24
```

And the expected output is:

```yaml
      - ipBlock:
          cidr: 172.17.0.0/16
          except:
          - 172.17.1.0/24
      - ipBlock:
          cidr: 10.0.0.1/24
```

4\. Create a function to handle filter based on podSelector

```yaml
{{/*
Generate netpol by Pod selector
*/}}

{{- define "netpol.scoped.podSelector" }}
{{- range .scope.podSelectors }}
{{- $labelYaml := toYaml .label }}
{{- if contains ":" $labelYaml }}
- podSelector:
    matchLabels: {{ toYaml .label | nindent 6 }}
    {{- if .matches }}
    {{- include "netpol.matcher" . | indent 4 }}
    {{- end }}
{{- else }}
- podSelector: {}
{{- end }}
{{- end }}
{{- end }}
```

***podSelector*** also capable to filter using expressions (**In, NotIn, Exists, NotExist**). Then we also create the function to handle the expressions and call it inside the template.

```yaml
{{/*
Generate matcher expression label
*/}}

{{- define "netpol.matcher" }}
matchExpressions:
{{- range .matches }}
{{- if hasKey . "matchIn" }}
- operator: In
  {{- range $key, $val := .matchIn }}
  key: {{ $key }}
  values: {{ toYaml $val | nindent 2 }}
  {{- end }}
{{- end }}

{{- if hasKey . "matchNotIn" }}
- operator: NotIn
  {{- range $key, $val := .matchNotIn }}
  key: {{ $key }}
  values: {{ toYaml $val | nindent 2 }}
  {{- end }}
{{- end }}

{{- if hasKey . "matchExists" }}
- operator: Exists
  key: {{ .matchExists }}
{{- end }}

{{- if hasKey . "matchNotExist" }}
- operator: DoesNotExist
  key: {{ .matchNotExist }}
{{- end }}

{{- end }}
{{- end }}
```

The example structure to add filter by Pod label is below:

```yaml
  ingress:
    podSelectors:
      - label:
          foo: bar
        matches:
          - matchIn:
              env:
              - foo
              - baz
```

And the expected output is:

```yaml
  ingress:
  - from:
    - podSelector:
        matchLabels:
          foo: bar
        matchExpressions:
        - operator: In
          key: env
          values:
          - foo
          - baz
```

5\. The next filter is **namespaceSelector**, this will handle filter rule within the cluster. Have a larger scope than the **podSelector**.

```yaml
{{/*
Generate netpol by Namespace selector
*/}}

{{- define "netpol.scoped.namespaceSelector" }}
{{- range .scope.namespaceSelectors }}
{{- $labelYaml := toYaml .label }}
{{- if contains ":" $labelYaml }}
- namespaceSelector:
    matchLabels: {{ toYaml .label | nindent 6 }}
    {{- if .matches }}
    {{- include "netpol.matcher" . | indent 4 }}
    {{- end }}
  {{- range .podSelectors }}
  podSelector:
    matchLabels: {{ toYaml .label | nindent 6 }}
    {{- if .matches }}
    {{- include "netpol.matcher" . | indent 4 }}
    {{- end }}
  {{- end }}
{{- else }}
- namespaceSelector: {}
  {{- range .podSelectors }}
  podSelector:
    matchLabels: {{ toYaml .label | nindent 6 }}
    {{- if .matches }}
    {{- include "netpol.matcher" . | indent 4 }}
    {{- end }}
  {{- end }}
{{- end }}
{{- end }}
{{- end }}
```

The example structure to add filter by Namespace label is below:

```yaml
    namespaceSelectors:
      - label: any
        podSelectors:
          - label:
              foo: bar
```

And the expected output is:

```yaml
    - namespaceSelector: {}
      podSelector:
        matchLabels:
          foo: bar
```

For the policy filtered by **podSelector** and **namespaceSelector** is available option to set “any”. It mean any Pods or Namespaces are allowed to access.

Last, we define a function to assign port into the rule.

```yaml
{{/*
Generate ports list
*/}}

{{- define "netpol.scoped.port" }}
ports:
{{- with .scope.ports }}
{{- if .tcp  }}
{{- range .tcp }}
- protocol: TCP
  port: {{ . }}
{{- end }}
{{- end }}

{{- if .udp }}
{{- range .udp }}
- protocol: UDP
  port: {{ . }}
{{- end }}
{{- end }}
```

All set, let’s we try. Helm provide command to test our templating is working well or not. We can run command helm template -s \<template file\> . --debug . In this case our Network Policy template is located in templates/networkpolicy.yaml .

To try this, we need to define the values on values.yaml file. This will be a default values to fill our chart.

```yaml
networkPolicies:
- name: "mysite-policy"
  podSelector:
    foo: bar
  ingress:
    cidrs:
      - ip: 10.0.0.1/16
        excepts:
        - 10.0.0.254/32
    podSelectors:
      - label:
          foo: bar
    ports:
      tcp:
      - 8080
```

On those example, let assume we want to allow access to our application that run on TCP port 8080 . We will give an access to Pod that have a label foo: bar and have a range of IP 10.0.0.1/16 , except 10.0.0.254 .

Then to render the template we can run command:

```yaml
helm template -s templates/networkpolicy.yaml . --debug

---
# Source: netpol/templates/networkpolicy.yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: mysite-policy
spec:
  podSelector:
    matchLabels:
      foo: bar
  ingress:
  - from:
    - ipBlock:
        cidr: 10.0.0.1/16
        except:
          - 10.0.0.254/32
    - podSelector:
        matchLabels:
          foo: bar
    ports:
    - protocol: TCP
      port: 8080
```

Source: <https://github.com/bagaswibowo25/netpol>

This my first article written on Medium. Hope I can consistently to share anything that I learned. Thanks for reading, hope it will help you to take advantage of Helm templates. If there any question or feedbacks drop in comment below.

Cheers!
