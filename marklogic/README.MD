Dockerfile to run a local Marklogic instance.





## Usage
- Download Marklogic's Centos RPM from http://developer.marklogic.com/
- The RPM should be located under this directory
- Build the image: docker build -t marklogic:9.0-4 .
- Create a container:
```
docker create --name=marklogic -p 8000:8000 -p 8001:8001 -p 8002:8002 -p 8010:8010 -p 8011:8011 marklogic:9.0-4
```
- Connect to the admin console: http://localhost:8001/
- Enter admin/admin as user/password

## Download rpm
https://developer.marklogic.com/products?d=/download/binaries/9.0/MarkLogic-9.0-4.x86_64.rpm


## reference
- https://developer.marklogic.com/blog/building-a-marklogic-docker-container
- https://developer.marklogic.com/blog/building-a-marklogic-docker-container
