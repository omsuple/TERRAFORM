#PROJECT2: VPC+EC2+NGINIX+HTTP ACCESS

What we need to create:

- A VPC with public and private subnet.
- A EC2 Instance using public subnet we created.
- Setup NGINIX Web Server
- Create Security group rule to enable HTTP access.
- Output the webserver url on terminal.

We'll create a new folder for this project and inside it we'll this time create sub files for separating our work, i.e we'll create file such as,
- main.tf (here we'll have our required provider)
- provider.tf (here we'll have our provider) 
- VPC.tf (here we'll create our VPC)
- EC2.tf (here we'll create our instance)
- Output.tf (here we'll have url as the output)
- security-groups.tf (we'll set inbound and outbound rule )
