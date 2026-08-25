package com.incidentgraph.repository;

import org.neo4j.driver.Driver;
import org.neo4j.driver.Record;
import org.neo4j.driver.Session;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

@Repository
public class IncidentRepository {
    private final Driver driver;

    public IncidentRepository(Driver driver) {
        this.driver = driver;
    }

    public List<Map<String, Object>> findAllIncidents() {

        String cypher = """
                MATCH (incident:IncidentGraph:Incident)
                RETURN incident.id AS id,
                       incident.title AS title,
                       incident.severity AS severity,
                       incident.status AS status,
                       incident.startedAt AS startedAt
                ORDER BY incident.startedAt DESC
                """;

        try (Session session = driver.session()) {

            return session.executeRead(tx -> {

                List<Map<String, Object>> incidents = new ArrayList<>();

                for (Record record : tx.run(cypher).list()) {
                    incidents.add(Map.of(
                            "id", record.get("id").asString(),
                            "title", record.get("title").asString(),
                            "severity", record.get("severity").asString(),
                            "status", record.get("status").asString(),
                            "startedAt", record.get("startedAt").asString()
                    ));
                }

                return incidents;
            });
        }
    }
    public Map<String, Object> findIncidentById(String incidentId) {

        String cypher = """
            MATCH (incident:IncidentGraph:Incident {id: $incidentId})
            OPTIONAL MATCH (incident)-[:CAUSED_BY]->(deployment:IncidentGraph:Deployment)
            OPTIONAL MATCH (deployment)-[:DEPLOYED_TO]->(service:IncidentGraph:Service)
            RETURN incident.id AS incidentId,
                   incident.title AS title,
                   incident.description AS description,
                   incident.severity AS severity,
                   incident.status AS status,
                   incident.startedAt AS startedAt,
                   deployment.id AS deploymentId,
                   deployment.version AS deploymentVersion,
                   deployment.status AS deploymentStatus,
                   service.id AS serviceId,
                   service.name AS serviceName,
                   service.status AS serviceStatus
            """;

        try (Session session = driver.session()) {

            return session.executeRead(tx -> {

                Record record = tx.run(
                        cypher,
                        Map.of("incidentId", incidentId)
                ).single();

                Map<String, Object> result = new HashMap<>();

                result.put("incidentId", record.get("incidentId").asString());
                result.put("title", record.get("title").asString());
                result.put("description", record.get("description").asString());
                result.put("severity", record.get("severity").asString());
                result.put("status", record.get("status").asString());
                result.put("startedAt", record.get("startedAt").asString());

                result.put("deploymentId", record.get("deploymentId").asString());
                result.put("deploymentVersion", record.get("deploymentVersion").asString());
                result.put("deploymentStatus", record.get("deploymentStatus").asString());

                result.put("serviceId", record.get("serviceId").asString());
                result.put("serviceName", record.get("serviceName").asString());
                result.put("serviceStatus", record.get("serviceStatus").asString());

                return result;
            });
        }
    }

    public Map<String, Object> analyzeImpact(String incidentId) {

        String cypher = """
            MATCH (incident:IncidentGraph:Incident {id: $incidentId})
                  -[:CAUSED_BY]->
                  (deployment:IncidentGraph:Deployment)
                  -[:DEPLOYED_TO]->
                  (service:IncidentGraph:Service)

            OPTIONAL MATCH (dependentService:IncidentGraph:Service)
                  -[:DEPENDS_ON*1..3]->
                  (service)

            OPTIONAL MATCH (dependentService)-[:PART_OF]->
                  (product:IncidentGraph:Product)
                  <-[:USES]-
                  (customer:IncidentGraph:Customer)

            WITH incident,
                 service,
                 collect(DISTINCT product.name) AS products,
                 count(DISTINCT customer) AS customerCount

            RETURN incident.id AS incidentId,
                   incident.title AS incidentTitle,
                   incident.severity AS severity,
                   service.name AS affectedService,
                   products,
                   customerCount
            """;

        try (Session session = driver.session()) {

            return session.executeRead(tx -> {

                Record record = tx.run(
                        cypher,
                        Map.of("incidentId", incidentId)
                ).single();

                Map<String, Object> result = new HashMap<>();

                result.put("incidentId",
                        record.get("incidentId").asString());

                result.put("incidentTitle",
                        record.get("incidentTitle").asString());

                result.put("severity",
                        record.get("severity").asString());

                result.put("affectedService",
                        record.get("affectedService").asString());

                result.put("affectedProducts",
                        record.get("products").asList());

                result.put("potentiallyAffectedCustomers",
                        record.get("customerCount").asInt());

                return result;
            });
        }
    }
    public List<Map<String, Object>> findDependencies(String incidentId) {

        String cypher = """
            MATCH (incident:IncidentGraph:Incident {id: $incidentId})
                  -[:CAUSED_BY]->
                  (:IncidentGraph:Deployment)
                  -[:DEPLOYED_TO]->
                  (service:IncidentGraph:Service)

            MATCH path =
                  (service)
                  <-[:DEPENDS_ON*1..3]-
                  (dependent:IncidentGraph:Service)

            RETURN DISTINCT
                   service.id AS affectedServiceId,
                   service.name AS affectedService,
                   dependent.id AS dependentServiceId,
                   dependent.name AS dependentService
            ORDER BY dependentService
            """;

        try (Session session = driver.session()) {

            return session.executeRead(tx -> {

                List<Map<String, Object>> dependencies = new ArrayList<>();

                for (Record record : tx.run(
                        cypher,
                        Map.of("incidentId", incidentId)
                ).list()) {

                    Map<String, Object> result = new HashMap<>();

                    result.put(
                            "affectedServiceId",
                            record.get("affectedServiceId").asString()
                    );

                    result.put(
                            "affectedService",
                            record.get("affectedService").asString()
                    );

                    result.put(
                            "dependentServiceId",
                            record.get("dependentServiceId").asString()
                    );

                    result.put(
                            "dependentService",
                            record.get("dependentService").asString()
                    );

                    dependencies.add(result);
                }

                return dependencies;
            });
        }
    }

}
