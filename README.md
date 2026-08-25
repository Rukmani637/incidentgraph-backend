# IncidentGraph Backend

IncidentGraph is an incident and impact analysis system designed to understand how an operational incident can affect products and their underlying service dependencies.

The backend provides REST APIs built with Spring Boot and uses CognoDB as a graph database to model relationships between incidents, products, services, and dependencies.

## Features

- Incident retrieval through REST APIs
- Incident detail analysis
- Technical impact analysis
- Identification of affected products
- Dependency impact analysis
- Graph-based relationship traversal using CognoDB
- RESTful backend architecture
- Production deployment using Docker and Render

## Tech Stack

- Java 17
- Spring Boot
- Maven
- CognoDB
- Graph database / Cypher
- Docker
- Render
- Git & GitHub

## Architecture

```text
React Frontend
      |
      | REST API
      v
Spring Boot Backend
      |
      | Graph queries
      v
CognoDB
      |
      v
Incident / Product / Service
Dependency Relationships
```
The backend is responsible for receiving requests from the frontend, querying the graph database, processing the relationships, and returning structured JSON responses.
## Graph Model
IncidentGraph uses a graph-based model to represent dependencies between operational components.

The graph contains connected entities such as:
```text
Incident
   |
   v
Product
   |
   v
Service
   |
   v
Dependency
```
This graph structure allows the application to trace relationships and determine potential downstream impact.
## API
The backend exposes REST endpoints used by the frontend.

Example:
```text
GET /api/incidents
```

Returns the available incidents.

The application also provides endpoints for incident details, impact analysis, and dependency impact analysis.

## Configuration

The application uses environment variables for database configuration.

Required environment variables:
```text
COGNODB_URI
COGNODB_USERNAME
COGNODB_PASSWORD
```
## Running Locally
### Prerequisites
- Java 17
- Maven
- CognoDB access
- Git

Clone the repository:
```text
git clone https://github.com/Rukmani637/incidentgraph-backend.git
cd incidentgraph-backend
```
Configure the required CognoDB environment variables.

Build the application:
```text
./mvnw clean package
```
On Windows:
```text
.\mvnw.cmd clean package
```
Run the application:
```text
.\mvnw.cmd spring-boot:run
```
The backend runs on:
```text
http://localhost:8080
```
## Docker
The application can also be built and run using Docker.
```text
docker build -t incidentgraph-backend .
docker run -p 8080:8080 incidentgraph-backend
```
## Deployment

The backend is deployed using:

- GitHub for source control
- Docker for containerization
- Render for backend hosting
- CognoDB for graph data

Production backend:
```text
https://incidentgraph-backend.onrender.com
```
## Project Purpose

IncidentGraph demonstrates how graph-based data modeling can be used for operational incident analysis.

Instead of treating incidents and dependencies as isolated records, the system represents their relationships as a connected graph. This makes it possible to trace dependencies and identify potentially affected products and services.

## Repository

GitHub:

https://github.com/Rukmani637/incidentgraph-backend