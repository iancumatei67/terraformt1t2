Minimal terraform configuration for accessing the sock-shop application. 
After the creation of the cluster and vpc, the application is run by connecting to the cluster locally and applying the resources from the Kubernetes configuration tfile that can be found here: https://github.com/kubeshark/sock-shop-demo/blob/master/deploy/kubernetes/complete-demo.yaml 

The application is the accessed bt using one of the nodes external IP's and the specific port for the web interface.
<img width="1785" alt="Screenshot 2024-08-26 at 11 09 59" src="https://github.com/user-attachments/assets/1d6c7629-8a97-4de9-a26e-067d1e8bd5c9">
