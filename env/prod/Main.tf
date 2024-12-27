module "prod" {
    source = "../../infra"

    nome_repositorio = "producao"

    cluster_name = "producao"
}
