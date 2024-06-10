function(config) {
  local value = {
    auths: {
      [config.azure.registry]: {
        username: config.azure.client_id,
        password: config.azure.client_secret,
        auth: std.base64(std.format('%s:%s',[config.azure.client_id, config.azure.client_secret])),
      },
    },
  },
  apiVersion: 'v1',
  kind: 'Secret',
  metadata: {
    name: 'acr-registry',
  },
  type: 'kubernetes.io/dockerconfigjson',
  data: {
    '.dockerconfigjson': std.base64(std.toString(value)),
  },
}
