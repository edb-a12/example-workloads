function(config)
  {
    apiVersion: 'networking.k8s.io/v1',
    kind: 'Ingress',
    metadata: {
      name: config.name + '-ingress',
      labels: {
        createdBy: 'signalbox',
      },
      annotations: {
        'nginx.ingress.kubernetes.io/force-ssl-redirect': 'true',
        'nginx.ingress.kubernetes.io/proxy-body-size': '0',
        // nginx.ingress.kubernetes.io/auth-type: basic
        // nginx.ingress.kubernetes.io/auth-secret: basic-auth
        // nginx.ingress.kubernetes.io/auth-realm: 'Authentication Required'
      },
    },
    spec: {
      ingressClassName: 'nginx',
      tls: [{
        hosts: [
          config.host,
        ],
      }],
      rules: [{
        host: config.host,
        http: {
          paths: [{
            path: '/',
            pathType: 'Prefix',
            backend: {
              service: {
                name: config.name + '-service',
                port: {
                  number: 80,
                },
              },
            },
          }],
        },
      }],
    },
  }
