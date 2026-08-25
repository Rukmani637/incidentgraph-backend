package com.incidentgraph.service;

import com.incidentgraph.repository.IncidentRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class IncidentService {
    private final IncidentRepository incidentRepository;

    public IncidentService(IncidentRepository incidentRepository) {
        this.incidentRepository = incidentRepository;
    }

    public List<Map<String, Object>> getAllIncidents() {
        return incidentRepository.findAllIncidents();
    }
    public Map<String, Object> getIncidentById(String incidentId) {
        return incidentRepository.findIncidentById(incidentId);
    }
    public Map<String, Object> analyzeImpact(String incidentId) {
        return incidentRepository.analyzeImpact(incidentId);
    }
    public List<Map<String, Object>> findDependencies(String incidentId) {
        return incidentRepository.findDependencies(incidentId);
    }
}
