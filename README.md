## Synopsis

Example to show runbook automation so you can manage, orchestra and like df -k, netstat -a etc for all managed servers in AWS EC2

## Code Example

Example of runbook automation. 

## Motivation

 
## Installation

First let's try:

    $ docker pull jordan/rundeck:latest
    latest: Pulling from jordan/rundeck
    > Digest: sha256:84fd657b265a06f53e5716f5e5cdf58b80bda9692b9fafd68b74426099793716

    $ docker run -p 4440:4440 -e SERVER_URL=http://localhost:4440 —name rundeck -t jordan/rundeck:latest

    $ docker ps -a
    
    $ docker stop rundeck
    
    $ docker rm rundeck


But prefer to build our own
    
    $ docker build -t sebc-rundeck .

    Sending build context to Docker daemon  5.497MB
    Step 1/8 : FROM jordan/rundeck:latest
     ---> a553fef39ef7
    Step 2/8 : MAINTAINER Sebastian Cheung <sebastian_cheung@live.com>
    ---> Running in 3949bf4899f8
    ---> e7710668817f
    Removing intermediate container 3949bf4899f8
    Step 3/8 : COPY rundeck-ec2-nodes-plugin-1.5.3.jar /var/lib/rundeck/libext/rundeck-ec2-nodes-plugin-1.5.3.jar
     ---> 2741d9856b47
    Removing intermediate container 6390f25c6624
    Step 4/8 : COPY infra-auto.pem /var/lib/rundeck/.ssh/id_rsa
     ---> 3c60fa50ae0d
    Removing intermediate container 180ad80474e6
    Step 5/8 : COPY infra-auto.pub /var/lib/rundeck/.ssh/id_rsa.pub
     ---> 2c4f4d3cc3ab
    Removing intermediate container a4eb47695979
    Step 6/8 : RUN chown rundeck:rundeck /var/lib/rundeck/.ssh/*
     ---> Running in 4d3cab101238
     ---> 8741cca0f96a
    Removing intermediate container 4d3cab101238
    Step 7/8 : ENV SERVER_URL http://localhost:4440
     ---> Running in 444ce6e54f7f
     ---> 15b05dad540b
    Removing intermediate container 444ce6e54f7f
    Step 8/8 : EXPOSE 4440
     ---> Running in 5e41aa81e654
     ---> d7b61f4cf5a9
    Removing intermediate container 5e41aa81e654
    Successfully built d7b61f4cf5a9
    Successfully tagged sebc-rundeck:latest



Then 

    $ docker run -dp 4440:4440  --name rundeck -t sebc-rundeck
    >73a9d839266f526b917e78f7d309a411df6464f240ff69506622864dfde01632

In browser localhost:4440

![Alt text](screenshot1.png?raw=true "Disk Space")

Login : admin
Password: admin

New Project -> Project Name: say for example
InfrastructureAutomation

Add Source -> AWS EC2 Resource -> AWS Access Key
AWS Secret Key -> Save

After which AWS EC@ Resources should show

Check SSH is setup

SSH Key File Path: /var/lib/rundeck/.ssh/id_rsa

Then Create 

Should show

New page InfrastructureAutomation ->
Create New Job

Add a Step -> Execute a remote command

Command df -k (for example free space)

Then SAVE

Click Dispatch to Nodes (provided AWS instances already setup)

Node Filter: .* (for all nodes)


![Alt text](screenshot3.png?raw=true "Activity Tab")
Editable filter : YES

Then Create


Click 'Run Job Now’ to start new job

Click ‘Log Output’

Run ad hoc settings:

On tab Command:
Command: netstat -a (show all network connections from those servers)
Nodes: tags:ec2 (this excludes our localhost)

Run on 2 Nodes


On Activity Tab: (this shows audit trail)
You can see all executions and who ran them
This reduces the interactive logins people perform and a compliance friendly audit trail. 
![Alt text](screenshot2.png?raw=true "Past Jobs")

A whole set of runback commands from basic information 
Gathering ones to support techs to ones that perform system
Changes and upgrades that engineers run.

The more you can code runbacks to meet common needs, instead of replying on people to remember the right way to do a task or to follow a written procedure, the more you can reduce errors.


## API Reference

Depending on the size of the project, if it is small and simple enough the reference docs can be added to the README. For medium size to larger projects it is important to at least provide a link to where the API reference docs live.

## Tests

Describe and show how to run the tests with code examples.

## Contributors

Let people know how they can dive into the project, include important links to things like issue trackers, irc, twitter accounts if applicable.

## License

A short snippet describing the license (MIT, Apache, etc.)