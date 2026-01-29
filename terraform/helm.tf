module "CERTMANAGER" {
  source = "./_modules/helm-release"

  namespace  = "cert-manager"
  repository = "https://charts.jetstack.io"

  app = {
    name          = "cert-manager"
    chart         = "cert-manager"
    version       = null
    force_update  = true
    wait          = true
    recreate_pods = true
    max_history   = 0
    lint          = true
  }

  set = [
    {
      name  = "installCRDs"
      value = "true"
    }
  ]
}


module "ARGOCD" {
  source = "./_modules/helm-release"

  namespace  = "argocd"
  repository = "https://argoproj.github.io/argo-helm"

  app = {
    create_namespace = true
    name             = "argocd"
    force_update     = true
    wait             = true
    recreate_pods    = true
    chart            = "argo-cd"
    version          = "3.35.4"
    timeout          = var.timeout_seconds
  }

  values = [file("./_modules/helm-release/argocd-values.yaml")]

}

module "TRAEFIK_CRDS" {
  source = "./_modules/helm-release"

  namespace  = "traefik"
  repository = "https://traefik.github.io/charts"

  app = {
    create_namespace = true
    name             = "traefik-crds"
    chart            = "traefik-crds"
    version          = "1.31.1"
    wait             = true
    force_update     = true
    recreate_pods    = false
    lint             = false
    timeout          = var.timeout_seconds
  }

  values = []
}


module "TRAEFIK" {
  source = "./_modules/helm-release"

  namespace  = "traefik"
  repository = "https://traefik.github.io/charts"

  app = {
    create_namespace = true
    name             = "traefik"
    force_update     = true
    wait             = true
    reuse_values     = true
    recreate_pods    = true
    version          = "21.1.0"
    chart            = "traefik"
    timeout          = var.timeout_seconds
  }

  values = [file("./_modules/helm-release/traefik-values.yaml")]

  depends_on = [module.TRAEFIK_CRDS]

}
