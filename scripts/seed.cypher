// ============================================================
// INCIDENTGRAPH - SEED DATA
// Production Incident & Impact Analysis
// ============================================================


// ============================================================
// 1. INCIDENTS
// ============================================================

UNWIND [
    {
        id: 'INC-1001',
        title: 'Payment Service Failure',
        description: 'Payment requests are failing after a production deployment.',
        severity: 'CRITICAL',
        status: 'INVESTIGATING',
        startedAt: '2026-08-24T10:30:00',
        resolvedAt: null
    },
    {
        id: 'INC-1002',
        title: 'Order Processing Delay',
        description: 'Orders are taking longer than expected to complete.',
        severity: 'HIGH',
        status: 'IDENTIFIED',
        startedAt: '2026-08-23T14:20:00',
        resolvedAt: null
    },
    {
        id: 'INC-1003',
        title: 'Inventory Synchronization Failure',
        description: 'Inventory quantities are not synchronizing correctly.',
        severity: 'HIGH',
        status: 'RESOLVED',
        startedAt: '2026-08-22T09:15:00',
        resolvedAt: '2026-08-22T12:40:00'
    },
    {
        id: 'INC-1004',
        title: 'Customer Login Errors',
        description: 'Customers are intermittently unable to log in.',
        severity: 'HIGH',
        status: 'RESOLVED',
        startedAt: '2026-08-21T18:10:00',
        resolvedAt: '2026-08-21T20:05:00'
    },
    {
        id: 'INC-1005',
        title: 'Notification Delivery Failure',
        description: 'Order confirmation notifications are delayed.',
        severity: 'MEDIUM',
        status: 'MONITORING',
        startedAt: '2026-08-20T11:45:00',
        resolvedAt: '2026-08-20T15:30:00'
    },
    {
        id: 'INC-1006',
        title: 'Product Search Degradation',
        description: 'Product search responses are slower than normal.',
        severity: 'MEDIUM',
        status: 'RESOLVED',
        startedAt: '2026-08-19T16:30:00',
        resolvedAt: '2026-08-19T18:15:00'
    },
    {
        id: 'INC-1007',
        title: 'Fraud Validation Timeout',
        description: 'Fraud checks are timing out for some transactions.',
        severity: 'HIGH',
        status: 'RESOLVED',
        startedAt: '2026-08-18T13:00:00',
        resolvedAt: '2026-08-18T14:25:00'
    },
    {
        id: 'INC-1008',
        title: 'Reporting Data Lag',
        description: 'Analytics dashboards are showing delayed data.',
        severity: 'LOW',
        status: 'RESOLVED',
        startedAt: '2026-08-17T08:00:00',
        resolvedAt: '2026-08-17T11:00:00'
    },
    {
        id: 'INC-1009',
        title: 'Checkout Timeout',
        description: 'Checkout requests occasionally exceed the response timeout.',
        severity: 'HIGH',
        status: 'INVESTIGATING',
        startedAt: '2026-08-16T19:10:00',
        resolvedAt: null
    },
    {
        id: 'INC-1010',
        title: 'Customer Portal Performance Issue',
        description: 'Customer portal pages are loading slowly.',
        severity: 'MEDIUM',
        status: 'RESOLVED',
        startedAt: '2026-08-15T10:00:00',
        resolvedAt: '2026-08-15T13:15:00'
    }
]
CREATE (n:IncidentGraph:Incident {
    id: row.id,
    title: row.title,
    description: row.description,
    severity: row.severity,
    status: row.status,
    startedAt: row.startedAt,
    resolvedAt: row.resolvedAt
});


// ============================================================
// 2. DEPLOYMENTS
// ============================================================

UNWIND [
    {id: 'DEP-2001', version: 'payment-v2.4.1', environment: 'PRODUCTION', deployedAt: '2026-08-24T10:15:00', status: 'FAILED'},
    {id: 'DEP-2002', version: 'order-v3.1.0', environment: 'PRODUCTION', deployedAt: '2026-08-23T13:45:00', status: 'SUCCESSFUL'},
    {id: 'DEP-2003', version: 'inventory-v1.8.2', environment: 'PRODUCTION', deployedAt: '2026-08-22T08:30:00', status: 'ROLLED_BACK'},
    {id: 'DEP-2004', version: 'auth-v4.0.2', environment: 'PRODUCTION', deployedAt: '2026-08-21T17:40:00', status: 'SUCCESSFUL'},
    {id: 'DEP-2005', version: 'notification-v2.7.0', environment: 'PRODUCTION', deployedAt: '2026-08-20T11:10:00', status: 'SUCCESSFUL'},
    {id: 'DEP-2006', version: 'search-v5.2.1', environment: 'PRODUCTION', deployedAt: '2026-08-19T16:00:00', status: 'ROLLED_BACK'},
    {id: 'DEP-2007', version: 'fraud-v2.1.4', environment: 'PRODUCTION', deployedAt: '2026-08-18T12:30:00', status: 'SUCCESSFUL'},
    {id: 'DEP-2008', version: 'reporting-v3.0.1', environment: 'PRODUCTION', deployedAt: '2026-08-17T07:30:00', status: 'SUCCESSFUL'},
    {id: 'DEP-2009', version: 'checkout-v6.1.0', environment: 'PRODUCTION', deployedAt: '2026-08-16T18:30:00', status: 'SUCCESSFUL'},
    {id: 'DEP-2010', version: 'portal-v4.3.0', environment: 'PRODUCTION', deployedAt: '2026-08-15T09:30:00', status: 'SUCCESSFUL'}
]
CREATE (n:IncidentGraph:Deployment {
    id: row.id,
    version: row.version,
    environment: row.environment,
    deployedAt: row.deployedAt,
    status: row.status
});


// ============================================================
// 3. SERVICES
// ============================================================

UNWIND [
    {id: 'SVC-PAYMENT', name: 'Payment Service', description: 'Processes customer payments.', status: 'DOWN', criticality: 'CRITICAL'},
    {id: 'SVC-PAYMENT-GATEWAY', name: 'Payment Gateway Service', description: 'Handles communication with external payment providers.', status: 'HEALTHY', criticality: 'CRITICAL'},
    {id: 'SVC-ORDER', name: 'Order Service', description: 'Creates and manages customer orders.', status: 'DEGRADED', criticality: 'CRITICAL'},
    {id: 'SVC-CHECKOUT', name: 'Checkout Service', description: 'Coordinates the customer checkout process.', status: 'DEGRADED', criticality: 'CRITICAL'},
    {id: 'SVC-INVENTORY', name: 'Inventory Service', description: 'Manages stock availability.', status: 'HEALTHY', criticality: 'HIGH'},
    {id: 'SVC-CATALOG', name: 'Catalog Service', description: 'Provides product catalog information.', status: 'HEALTHY', criticality: 'MEDIUM'},
    {id: 'SVC-AUTH', name: 'Authentication Service', description: 'Handles customer authentication.', status: 'HEALTHY', criticality: 'CRITICAL'},
    {id: 'SVC-NOTIFICATION', name: 'Notification Service', description: 'Sends customer notifications.', status: 'HEALTHY', criticality: 'MEDIUM'},
    {id: 'SVC-USER', name: 'User Service', description: 'Manages customer profile information.', status: 'HEALTHY', criticality: 'HIGH'},
    {id: 'SVC-REPORTING', name: 'Reporting Service', description: 'Aggregates operational and business reporting data.', status: 'HEALTHY', criticality: 'LOW'},
    {id: 'SVC-FRAUD', name: 'Fraud Detection Service', description: 'Evaluates transactions for fraud risk.', status: 'HEALTHY', criticality: 'HIGH'},
    {id: 'SVC-SEARCH', name: 'Search Service', description: 'Provides product search functionality.', status: 'HEALTHY', criticality: 'MEDIUM'}
]
CREATE (n:IncidentGraph:Service {
    id: row.id,
    name: row.name,
    description: row.description,
    status: row.status,
    criticality: row.criticality
});


// ============================================================
// 4. DATABASES
// ============================================================

UNWIND [
    {id: 'DB-PAYMENT', name: 'Payment Database', type: 'PostgreSQL', environment: 'PRODUCTION', status: 'HEALTHY'},
    {id: 'DB-ORDER', name: 'Order Database', type: 'PostgreSQL', environment: 'PRODUCTION', status: 'HEALTHY'},
    {id: 'DB-INVENTORY', name: 'Inventory Database', type: 'PostgreSQL', environment: 'PRODUCTION', status: 'HEALTHY'},
    {id: 'DB-CATALOG', name: 'Catalog Database', type: 'MongoDB', environment: 'PRODUCTION', status: 'HEALTHY'},
    {id: 'DB-USER', name: 'User Database', type: 'PostgreSQL', environment: 'PRODUCTION', status: 'HEALTHY'},
    {id: 'DB-REPORTING', name: 'Reporting Database', type: 'PostgreSQL', environment: 'PRODUCTION', status: 'HEALTHY'}
]
CREATE (n:IncidentGraph:Database {
    id: row.id,
    name: row.name,
    type: row.type,
    environment: row.environment,
    status: row.status
});


// ============================================================
// 5. APIS
// ============================================================

UNWIND [
    {id: 'API-PAYMENT-GATEWAY', name: 'Payment Gateway API', provider: 'External Payment Provider', version: 'v3', status: 'HEALTHY'},
    {id: 'API-FRAUD-CHECK', name: 'Fraud Check API', provider: 'Risk Platform', version: 'v2', status: 'HEALTHY'},
    {id: 'API-SMS', name: 'SMS Notification API', provider: 'Notification Provider', version: 'v1', status: 'HEALTHY'},
    {id: 'API-EMAIL', name: 'Email Notification API', provider: 'Email Provider', version: 'v2', status: 'HEALTHY'},
    {id: 'API-ADDRESS', name: 'Address Validation API', provider: 'Address Provider', version: 'v2', status: 'HEALTHY'},
    {id: 'API-TAX', name: 'Tax Calculation API', provider: 'Tax Provider', version: 'v1', status: 'HEALTHY'}
]
CREATE (n:IncidentGraph:API {
    id: row.id,
    name: row.name,
    provider: row.provider,
    version: row.version,
    status: row.status
});


// ============================================================
// 6. TEAMS
// ============================================================

UNWIND [
    {id: 'IG-TEAM-PAYMENTS', name: 'Payments Engineering', department: 'Engineering'},
    {id: 'IG-TEAM-ORDERS', name: 'Orders Engineering', department: 'Engineering'},
    {id: 'IG-TEAM-CHECKOUT', name: 'Checkout Engineering', department: 'Engineering'},
    {id: 'IG-TEAM-PLATFORM', name: 'Platform Engineering', department: 'Engineering'},
    {id: 'IG-TEAM-SECURITY', name: 'Security Engineering', department: 'Security'}
]
CREATE (n:IncidentGraph:Team {
    id: row.id,
    name: row.name,
    department: row.department
});


// ============================================================
// 7. PRODUCTS
// ============================================================

UNWIND [
    {id: 'PROD-CHECKOUT', name: 'Checkout Platform', category: 'E-Commerce', status: 'DEGRADED'},
    {id: 'PROD-ORDER-MANAGEMENT', name: 'Order Management Platform', category: 'E-Commerce', status: 'ACTIVE'},
    {id: 'PROD-CUSTOMER-PORTAL', name: 'Customer Portal', category: 'Customer Experience', status: 'ACTIVE'},
    {id: 'PROD-INVENTORY', name: 'Inventory Platform', category: 'Operations', status: 'ACTIVE'},
    {id: 'PROD-ANALYTICS', name: 'Analytics Platform', category: 'Business Intelligence', status: 'ACTIVE'}
]
CREATE (n:IncidentGraph:Product {
    id: row.id,
    name: row.name,
    category: row.category,
    status: row.status
});


// ============================================================
// 8. CUSTOMERS
// ============================================================

UNWIND [
    {id: 'CUS-1001', name: 'Customer 1001', segment: 'Enterprise', region: 'APAC'},
    {id: 'CUS-1002', name: 'Customer 1002', segment: 'Enterprise', region: 'EMEA'},
    {id: 'CUS-1003', name: 'Customer 1003', segment: 'SMB', region: 'APAC'},
    {id: 'CUS-1004', name: 'Customer 1004', segment: 'SMB', region: 'NA'},
    {id: 'CUS-1005', name: 'Customer 1005', segment: 'Enterprise', region: 'NA'},
    {id: 'CUS-1006', name: 'Customer 1006', segment: 'Consumer', region: 'APAC'},
    {id: 'CUS-1007', name: 'Customer 1007', segment: 'Consumer', region: 'EMEA'},
    {id: 'CUS-1008', name: 'Customer 1008', segment: 'Enterprise', region: 'APAC'},
    {id: 'CUS-1009', name: 'Customer 1009', segment: 'SMB', region: 'EMEA'},
    {id: 'CUS-1010', name: 'Customer 1010', segment: 'Consumer', region: 'NA'},
    {id: 'CUS-1011', name: 'Customer 1011', segment: 'Enterprise', region: 'APAC'},
    {id: 'CUS-1012', name: 'Customer 1012', segment: 'SMB', region: 'NA'},
    {id: 'CUS-1013', name: 'Customer 1013', segment: 'Consumer', region: 'APAC'},
    {id: 'CUS-1014', name: 'Customer 1014', segment: 'Enterprise', region: 'EMEA'},
    {id: 'CUS-1015', name: 'Customer 1015', segment: 'SMB', region: 'APAC'},
    {id: 'CUS-1016', name: 'Customer 1016', segment: 'Consumer', region: 'NA'},
    {id: 'CUS-1017', name: 'Customer 1017', segment: 'Enterprise', region: 'NA'},
    {id: 'CUS-1018', name: 'Customer 1018', segment: 'EMEA', region: 'EMEA'},
    {id: 'CUS-1019', name: 'Customer 1019', segment: 'SMB', region: 'APAC'},
    {id: 'CUS-1020', name: 'Customer 1020', segment: 'Consumer', region: 'NA'}
]
CREATE (n:IncidentGraph:Customer {
    id: row.id,
    name: row.name,
    segment: row.segment,
    region: row.region
});


// ============================================================
// 9. INCIDENT → DEPLOYMENT
// ============================================================

UNWIND [
    ['INC-1001', 'DEP-2001'],
    ['INC-1002', 'DEP-2002'],
    ['INC-1003', 'DEP-2003'],
    ['INC-1004', 'DEP-2004'],
    ['INC-1005', 'DEP-2005'],
    ['INC-1006', 'DEP-2006'],
    ['INC-1007', 'DEP-2007'],
    ['INC-1008', 'DEP-2008'],
    ['INC-1009', 'DEP-2009'],
    ['INC-1010', 'DEP-2010']
] AS pair
MATCH (i:IncidentGraph:Incident {id: pair[0]})
MATCH (d:IncidentGraph:Deployment {id: pair[1]})
MERGE (i)-[:CAUSED_BY]->(d);


// ============================================================
// 10. DEPLOYMENT → SERVICE
// ============================================================

UNWIND [
    ['DEP-2001', 'SVC-PAYMENT'],
    ['DEP-2002', 'SVC-ORDER'],
    ['DEP-2003', 'SVC-INVENTORY'],
    ['DEP-2004', 'SVC-AUTH'],
    ['DEP-2005', 'SVC-NOTIFICATION'],
    ['DEP-2006', 'SVC-SEARCH'],
    ['DEP-2007', 'SVC-FRAUD'],
    ['DEP-2008', 'SVC-REPORTING'],
    ['DEP-2009', 'SVC-CHECKOUT'],
    ['DEP-2010', 'SVC-USER']
] AS pair
MATCH (d:IncidentGraph:Deployment {id: pair[0]})
MATCH (s:IncidentGraph:Service {id: pair[1]})
MERGE (d)-[:DEPLOYED_TO]->(s);


// ============================================================
// 11. SERVICE → SERVICE DEPENDENCIES
// ============================================================

UNWIND [
    ['SVC-CHECKOUT', 'SVC-ORDER'],
    ['SVC-CHECKOUT', 'SVC-CATALOG'],
    ['SVC-CHECKOUT', 'SVC-AUTH'],
    ['SVC-ORDER', 'SVC-PAYMENT'],
    ['SVC-ORDER', 'SVC-INVENTORY'],
    ['SVC-PAYMENT', 'SVC-PAYMENT-GATEWAY'],
    ['SVC-PAYMENT', 'SVC-FRAUD'],
    ['SVC-NOTIFICATION', 'SVC-USER'],
    ['SVC-REPORTING', 'SVC-ORDER'],
    ['SVC-REPORTING', 'SVC-PAYMENT'],
    ['SVC-USER', 'SVC-AUTH'],
    ['SVC-SEARCH', 'SVC-CATALOG']
] AS pair
MATCH (source:IncidentGraph:Service {id: pair[0]})
MATCH (target:IncidentGraph:Service {id: pair[1]})
MERGE (source)-[:DEPENDS_ON]->(target);


// ============================================================
// 12. SERVICE → DATABASE
// ============================================================

UNWIND [
    ['SVC-PAYMENT', 'DB-PAYMENT'],
    ['SVC-PAYMENT-GATEWAY', 'DB-PAYMENT'],
    ['SVC-ORDER', 'DB-ORDER'],
    ['SVC-INVENTORY', 'DB-INVENTORY'],
    ['SVC-CATALOG', 'DB-CATALOG'],
    ['SVC-USER', 'DB-USER'],
    ['SVC-REPORTING', 'DB-REPORTING']
] AS pair
MATCH (s:IncidentGraph:Service {id: pair[0]})
MATCH (d:IncidentGraph:Database {id: pair[1]})
MERGE (s)-[:USES]->(d);


// ============================================================
// 13. SERVICE → API
// ============================================================

UNWIND [
    ['SVC-PAYMENT-GATEWAY', 'API-PAYMENT-GATEWAY'],
    ['SVC-FRAUD', 'API-FRAUD-CHECK'],
    ['SVC-NOTIFICATION', 'API-SMS'],
    ['SVC-NOTIFICATION', 'API-EMAIL'],
    ['SVC-CHECKOUT', 'API-ADDRESS'],
    ['SVC-ORDER', 'API-TAX']
] AS pair
MATCH (s:IncidentGraph:Service {id: pair[0]})
MATCH (a:IncidentGraph:API {id: pair[1]})
MERGE (s)-[:CALLS]->(a);


// ============================================================
// 14. SERVICE → TEAM
// ============================================================

UNWIND [
    ['SVC-PAYMENT', 'IG-TEAM-PAYMENTS'],
    ['SVC-PAYMENT-GATEWAY', 'IG-TEAM-PAYMENTS'],
    ['SVC-ORDER', 'IG-TEAM-ORDERS'],
    ['SVC-CHECKOUT', 'IG-TEAM-CHECKOUT'],
    ['SVC-INVENTORY', 'IG-TEAM-ORDERS'],
    ['SVC-CATALOG', 'IG-TEAM-PLATFORM'],
    ['SVC-AUTH', 'IG-TEAM-SECURITY'],
    ['SVC-NOTIFICATION', 'IG-TEAM-PLATFORM'],
    ['SVC-USER', 'IG-TEAM-PLATFORM'],
    ['SVC-REPORTING', 'IG-TEAM-PLATFORM'],
    ['SVC-FRAUD', 'IG-TEAM-SECURITY'],
    ['SVC-SEARCH', 'IG-TEAM-PLATFORM']
] AS pair
MATCH (s:IncidentGraph:Service {id: pair[0]})
MATCH (t:IncidentGraph:Team {id: pair[1]})
MERGE (s)-[:OWNED_BY]->(t);


// ============================================================
// 15. SERVICE → PRODUCT
// ============================================================

UNWIND [
    ['SVC-CHECKOUT', 'PROD-CHECKOUT'],
    ['SVC-PAYMENT', 'PROD-CHECKOUT'],
    ['SVC-ORDER', 'PROD-ORDER-MANAGEMENT'],
    ['SVC-INVENTORY', 'PROD-INVENTORY'],
    ['SVC-CATALOG', 'PROD-CHECKOUT'],
    ['SVC-AUTH', 'PROD-CUSTOMER-PORTAL'],
    ['SVC-USER', 'PROD-CUSTOMER-PORTAL'],
    ['SVC-REPORTING', 'PROD-ANALYTICS'],
    ['SVC-SEARCH', 'PROD-CHECKOUT']
] AS pair
MATCH (s:IncidentGraph:Service {id: pair[0]})
MATCH (p:IncidentGraph:Product {id: pair[1]})
MERGE (s)-[:PART_OF]->(p);


// ============================================================
// 16. CUSTOMER → PRODUCT
// ============================================================

UNWIND [
    ['CUS-1001', 'PROD-CHECKOUT'],
    ['CUS-1002', 'PROD-CHECKOUT'],
    ['CUS-1003', 'PROD-CHECKOUT'],
    ['CUS-1004', 'PROD-CHECKOUT'],
    ['CUS-1005', 'PROD-CHECKOUT'],
    ['CUS-1006', 'PROD-CHECKOUT'],
    ['CUS-1007', 'PROD-CHECKOUT'],
    ['CUS-1008', 'PROD-CHECKOUT'],
    ['CUS-1009', 'PROD-CHECKOUT'],
    ['CUS-1010', 'PROD-CHECKOUT'],
    ['CUS-1011', 'PROD-ORDER-MANAGEMENT'],
    ['CUS-1012', 'PROD-ORDER-MANAGEMENT'],
    ['CUS-1013', 'PROD-ORDER-MANAGEMENT'],
    ['CUS-1014', 'PROD-CUSTOMER-PORTAL'],
    ['CUS-1015', 'PROD-CUSTOMER-PORTAL'],
    ['CUS-1016', 'PROD-CUSTOMER-PORTAL'],
    ['CUS-1017', 'PROD-INVENTORY'],
    ['CUS-1018', 'PROD-INVENTORY'],
    ['CUS-1019', 'PROD-ANALYTICS'],
    ['CUS-1020', 'PROD-ANALYTICS']
] AS pair
MATCH (c:IncidentGraph:Customer {id: pair[0]})
MATCH (p:IncidentGraph:Product {id: pair[1]})
MERGE (c)-[:USES]->(p);