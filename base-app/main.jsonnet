function(config)
{
  local deployment = import './lib/deployment.jsonnet',
  local ingress = import './lib/ingress.jsonnet',
  local service = import './lib/service.jsonnet',
  local acrsecret = import './lib/acrsecret.jsonnet',
  apiVersion: 'v1',
  kind: 'List',
  items: [
    deployment(config),
    // ingress(config),
    // service(config),
    // acrsecret(config),
  ],
}