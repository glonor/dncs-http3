# PERFORMANCE EVALUATION OF HTTP/3 + QUIC

## Index

* [Introduction](#introduction)
* [Design](#design)
  * [Vagrant](#vagrant)
  * [Docker](#docker)
* [Performance evaluation](#performance-Evaluation)
* [Conclusions](#conclusions)
&nbsp;


## Introduction

The project's scope is to create a virtual network to compare the performance of HTTP/3 with respect to HTTP/2 and TCP.
To do this we used Vagrant and Virtualbox for managing the virtual machines, and Docker to run the web-server.

Suggested reference: https://blog.cloudflare.com/experiment-with-http-3-using-nginx-and-quiche/

## Design

The network setup is the following:

* One host used as a client
* One host used as a web-server
* One host used as a router

The client will be connected to the router, and the router to the web-server which belongs to a different subnet, creating a realistic yet simple situation.

The web-server will run 3 Docker containers, one for each protocol to be tested.
The client will run Google Chrome.
The entire environment will be managed by Vagrant. 

| Host         | Interface     | IP address  | Subnet  |
| -------------| ------------- | ----------- | ------- |
| Client       | enp0s8        | 192.168.0.2 |    1    |
| Router       | enp0s8        | 192.168.0.1 |    1    |
| Router       | enp0s9        | 192.168.2.1 |    2    |
| Web-server   | enp0s8        | 192.168.2.2 |    2    |

The 3 Docker containers are reachable through the following ports:

| Protocol      | Ports         | 
| ------------- | ------------- |
| TCP           |   100 , 743   |
| HTTP/2        |   90  , 643   |
| HTTP/3 + QUIC |   80  , 443   |


## Implementation

In order to create such environment, we modified the vagrant file and created one start-up script for each host.
Then we configured Docker, the details of this will be discussed below.

### Vagrant

The important things to highlight in the vagrant file are the following:

- The OS chosen for the hosts is ubuntu/bionic64
- The client and the server have 1024 MB of RAM to be able to run the docker images
- To use the browser and the related dev tools it's necessary to add the following lines: 
```Ruby
  config.ssh.forward_agent = true
  config.ssh.forward_x11 = true
```
It's also necesary, for the host machine, to run an X-server, like Xming.

### Docker
In the container 3 websites can be found:
  - Game of Thrones 
![image](https://user-images.githubusercontent.com/74667849/115530108-c392c480-a293-11eb-9bc9-c8786cd0f609.png)

  - Global master 
 ![image](https://user-images.githubusercontent.com/74667849/115530015-af4ec780-a293-11eb-9766-d0246da6c9e1.png)

  - Eforlad travel
![image](https://user-images.githubusercontent.com/74667849/115530279-e91fce00-a293-11eb-90ca-0b12e5c6ec25.png)

#### Characteristics 
|                    | Game of Thrones  | Global master  | Eforlad travel  |
| ------------------ | ---------------- | -------------- | --------------- |
| Weight             | 3 MB             | 1 MB           | 2 MB            |
| Number of requests | 39               | 56             | 19              |

## Performance evaluation

As mentioned earlier, to compare the various protocols performance we used Google Chrome and its Dev Tools.

After the system is running, Chrome must be run using this command:

```bash
google-chrome --enable-quic --quic-version=h3-27
```
This will launch Chrome and enable quic.


### Evaluation criteria

- Page weight: the total weight of the entire page
- Load time: the total time needed to load the page
- Number of requests: how many requests were made by the browser in the process

### Results

#### Game of Thrones
![image](https://user-images.githubusercontent.com/74667849/115529342-1e77ec00-a293-11eb-9046-afeaf2f1241a.png)

#### Global master
![image](https://user-images.githubusercontent.com/74667849/115527790-aceb6e00-a291-11eb-8216-5e341bb605f9.png)


#### Eforlad travel
![image](https://user-images.githubusercontent.com/74667849/115528908-bcb78200-a292-11eb-9b45-de089e86646f.png)

## Conclusions
Although we thought the HTTP3+QUIC was the fastest protocol, during the experiments and as can be seen in the results, the TCP protocol was the swiftest.
Another important statement is that the loading time is more influenced by the number of requst instead of the page weight. In fact, the page Game of Thrones has more requests, 39 vs 56 of Erforlad travel, and its time, using TCP as reference, is 537 ms vs 916 ms. 

