function(config)
{
    apiVersion: 'apps/v1',
    kind: 'Deployment',
    metadata: {
      name: "basic-app",
      labels: {
        createdBy: 'signalbox',
      },
    },
    spec: {
      replicas: 1,
      selector: {
        matchLabels: {
          app: "basic-app",
        },
      },
      template: {
        metadata: {
          labels: {
            app: "basic-app",
            createdBy: 'signalbox',
          },
        },
        spec: {
          containers: [{
            name: 'app',
            image: if config.maintenance then "wickerlabs/maintenance" else config.image,
            ports: [{
              containerPort: config.port,
            }],
          }],
        },
      },
    },
}