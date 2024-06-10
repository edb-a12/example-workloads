function(config) {
  apiVersion: 'v1',
  kind: 'Service',
  metadata: {
    name: config.name + '-service',
    labels: {
      createdBy: "signalbox",
    },
  },
  spec: {
    selector: {
      app: config.name,
    },
    ports: [{
      port: config.port,
    }],
    type: 'NodePort',
  },
}
