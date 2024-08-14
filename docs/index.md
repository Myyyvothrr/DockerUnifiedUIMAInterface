---
layout: default
---
Automatic analysis of large text corpora is a complex task. This complexity particularly concerns the question of time efficiency. Furthermore, efficient, flexible, and extensible textanalysis requires the continuous integration of every new text analysis tools. Since there are currently, in the area of NLP and especially in the application context of UIMA, only very few to no adequate frameworks for these purposes, which are not simultaneously outdated or can no longer be used for security reasons, this work will present a new approach to fill this gap. To this end, we present Docker Unified UIMA Interface (DUUI), a scalable, flexible, lightweight, and featurerich framework for automated and distributed analysis of text corpora that leverages experience in Big Data analytics and virtualization with Docker.

[![](https://jitpack.io/v/texttechnologylab/DockerUnifiedUIMAInterface.svg)](https://jitpack.io/#texttechnologylab/DockerUnifiedUIMAInterface)
![GitHub License](https://img.shields.io/github/license/Texttechnologylab/DockerUnifiedUIMAInterface)
![GitHub release (with filter)](https://img.shields.io/github/v/release/Texttechnologylab/DockerUnifiedUIMAInterface)
[![javadoc](https://img.shields.io/badge/javadoc-latest-yellow)](javadoc)
[![Conference](http://img.shields.io/badge/conference-FindingsEMNLP--2023-4b44ce.svg)](https://2023.emnlp.org/)
[![Paper](http://img.shields.io/badge/paper-FindingsEMNLP--2023-fb44ce.svg)](https://aclanthology.org/2023.findings-emnlp.29)


## Features
Using DUUI, NLP preprocessing on texts can be performed using the following features:
* Horizontal and vertical scaling
* Capturing heterogeneous annotation landscapes
* Capturing heterogeneous implementation landscapes
* Reproducible & reusable annotations
* Monitoring and error-reporting
* Lightweight usability

## Functions
DUUI has different components which are distinguished into Drivers and Components.

### Components
Components represent the actual analysis methods for recognizing (among others) tokens, named entities, POS and other ingredients of the NLP. All components must be analysis methods in the definition of UIMA. Of course, existing analysis methods based on Java can also be used directly (e.g. dkpro).

Independently of this, Components can also be implemented in alternative programming languages, as long as the interface of DUUI is used, they can be targeted and used.

### Driver
DUUI has a variety of drivers that enable communication as well as the execution of Components in different runtime environments.

#### UIMADriver
The UIMADriver runs a UIMA Analysis Engine (AE) on the local machine (using local memory and processor) in the same process within the JRE and allows scaling on that machine by replicating the underlying Analysis Engine. This enables the use of all previous analysis methods based on UIMA AE without further adjustments.

#### DockerDriver
The DUUI core driver runs Components on the local Docker daemon and enables machine-specific resource management. This requires that the AEs are available as Docker images according to DUUI to run as Docker containers. It is not relevant whether the Docker image is stored locally or in a remote registry, since the Docker container is built on startup. This makes it very easy to test new AEs (as local containers) before being released. The distinction between local and remote Docker images is achieved by the URI of the Docker image used

#### RemoteDriver
AEs that are not available as containers and whose models can or should not be shared can still be used if they are available via REST. Since DUUI communicates via RESTful, remote endpoints can be used for pre-processing. In general, AEs implemented based on DUUI can be accessed and used via REST, but the scaling is limited regarding request and processing capabilities of the hosting system. In addition, Components addressed via the RemoteDRiver can be used as services. This has advantages for AEs that need to hold large models in memory and thus require a long startup time. To avoid continuous reloading, it may be necessary to start a service once or twice in a dedicated mode and then use a RemoteDriver to access it. To use services, their URL must be specified to enable horizontal scaling.

#### SwarmDriver
The SwarmDriver complements the DockerDriver; it uses the same function alities, but its AEs are used as Docker images distributed within the Docker Swarm network. A swarm consists of n nodes and is controlled by a leader node within the Docker framework. However, if an application using DUUI is executed on a Docker leader node, the individual AEs can be executed on multiple swarm nodes.

#### KubernetesDriver
The KubernetesDriver works similarly to the SwarmDriver, but Kubernetes is used as the runtime environment instead of Docker Swarm.

## Requirements
![Java](https://img.shields.io/badge/Java-17-blue)
![Docker](https://img.shields.io/badge/Docker-22.10-green)

## UIMA-Components
A list of existing DUUI components as Docker images can be found [here](https://github.com/texttechnologylab/duui-uima).

> [!NOTE]
> Instructions for creating your own DUUI components and detailed explanations can be found under [Tutorials](tutorial/Tutorial).

## Using
There are basically two ways to use DUUI for preprocessing texts:
 * Clone the GitHub project.
 * Include the GitHub project using JitPack via maven (Recommended).

## Using JitPack
Add the following to your pom file:
```xml
<repositories>
  <repository>
      <id>jitpack.io</id>
      <url>https://jitpack.io</url>
  </repository>
</repositories>
```
After that DUUI can be integrated as a dependency:

```xml
<dependency>
  <groupId>com.github.texttechnologylab</groupId>
  <artifactId>DockerUnifiedUIMAInterface</artifactId>
  <version>1.3</version>
</dependency>
```



# Cite
If you want to use the project please quote this as follows:

Alexander Leonhardt, Giuseppe Abrami, Daniel Baumartz and Alexander Mehler. (2023). "Unlocking the Heterogeneous Landscape of Big Data NLP with DUUI." Findings of the Association for Computational Linguistics: EMNLP 2023, 385–399. [[LINK](https://aclanthology.org/2023.findings-emnlp.29)] [[PDF](https://aclanthology.org/2023.findings-emnlp.29.pdf)]

## BibTeX
```
@inproceedings{Leonhardt:et:al:2023,
  title     = {Unlocking the Heterogeneous Landscape of Big Data {NLP} with {DUUI}},
  author    = {Leonhardt, Alexander and Abrami, Giuseppe and Baumartz, Daniel and Mehler, Alexander},
  editor    = {Bouamor, Houda and Pino, Juan and Bali, Kalika},
  booktitle = {Findings of the Association for Computational Linguistics: EMNLP 2023},
  year      = {2023},
  address   = {Singapore},
  publisher = {Association for Computational Linguistics},
  url       = {https://aclanthology.org/2023.findings-emnlp.29},
  pages     = {385--399},
  pdf       = {https://aclanthology.org/2023.findings-emnlp.29.pdf},
  abstract  = {Automatic analysis of large corpora is a complex task, especially
               in terms of time efficiency. This complexity is increased by the
               fact that flexible, extensible text analysis requires the continuous
               integration of ever new tools. Since there are no adequate frameworks
               for these purposes in the field of NLP, and especially in the
               context of UIMA, that are not outdated or unusable for security
               reasons, we present a new approach to address the latter task:
               Docker Unified UIMA Interface (DUUI), a scalable, flexible, lightweight,
               and feature-rich framework for automatic distributed analysis
               of text corpora that leverages Big Data experience and virtualization
               with Docker. We evaluate DUUI{'}s communication approach against
               a state-of-the-art approach and demonstrate its outstanding behavior
               in terms of time efficiency, enabling the analysis of big text
               data.}
}
```