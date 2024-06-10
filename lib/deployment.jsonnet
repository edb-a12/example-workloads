function(config)
  {
    apiVersion: 'apps/v1',
    kind: 'Deployment',
    metadata: {
      name: config.name,
      labels: {
        createdBy: 'signalbox',
      },
    },
    spec: {
      replicas: config.replicas,
      selector: {
        matchLabels: {
          app: config.name,
        },
      },
      template: {
        metadata: {
          labels: {
            app: config.name,
            createdBy: 'signalbox',
          },
        },
        spec: {
          imagePullSecrets: [
            { name: 'acr-registry' },
          ],
          containers: [{
            name: 'app',
            image: config.build.image,
            ports: [{
              containerPort: config.port,
            }],
            startupProbe: {
              failureThreshold: 60,
              successThreshold: 1,
              periodSeconds: 10,
              timeoutSeconds: 10,
              httpGet: {
                path: config.healthPath,
                port: config.port,
                httpHeaders: [{
                  name: 'Host',
                  value: config.host,
                }],
              },
              initialDelaySeconds: 10,
            },
            livenessProbe: {
              timeoutSeconds: 10,
              failureThreshold: 2,
              successThreshold: 1,
              periodSeconds: 30,
              httpGet: {
                path: config.healthPath,
                port: config.port,
                httpHeaders: [{
                  name: 'Host',
                  value: config.host,
                }],
              },
            },
            env: [{
              name: 'APP_NAME',
              value: config.name,
            }],
            volumeMounts: [{
              name: 'mount-example',
              mountPath: '/mnt/path',
            }],
            resources: {
              requests: {
                memory: config.memory,
                cpu: config.cpu,
              },
              limits: {
                memory: config.memory,
              },
            },
          }],
          volumes: [{
            name: 'mount-example',
            persistentVolumeClaim: {
              claimName: 'mount-example-disk',
            },
          }],
        },
      },
    },
  }
