package com.incidentgraph.controller;

import com.incidentgraph.service.IncidentService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/incidents")
public class IncidentController {
    private final IncidentService incidentService;

    public IncidentController(IncidentService incidentService) {
        this.incidentService = incidentService;
    }

    @GetMapping
    public List<Map<String, Object>> getAllIncidents() {
        return incidentService.getAllIncidents();
    }
    @GetMapping("/{incidentId}")
    public Map<String, Object> getIncidentById(
            @PathVariable String incidentId) {

        return incidentService.getIncidentById(incidentId);
    }
    @GetMapping("/{incidentId}/impact")
    public Map<String, Object> analyzeImpact(
            @PathVariable String incidentId) {

        return incidentService.analyzeImpact(incidentId);
    }
    @GetMapping("/{incidentId}/dependencies")
    public List<Map<String, Object>> getDependencies(
            @PathVariable String incidentId) {

        return incidentService.findDependencies(incidentId);
    }
}
