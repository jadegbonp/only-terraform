# diagram.py
from diagrams import Diagram
from diagrams.aws.compute import EC2SpotInstance


with Diagram("hello-world", filename="./assets/hello-world", show=False, outformat="png"):
    EC2SpotInstance("CheapInstance")