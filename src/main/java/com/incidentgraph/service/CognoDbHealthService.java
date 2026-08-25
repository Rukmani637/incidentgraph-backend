package com.incidentgraph.service;

import org.neo4j.driver.Driver;
import org.springframework.stereotype.Service;

@Service
public class CognoDbHealthService {
    private final Driver driver;

    public CognoDbHealthService(Driver driver) {
        this.driver = driver;
    }

    public boolean isConnected() {
        driver.verifyConnectivity();
        return true;
    }
}
