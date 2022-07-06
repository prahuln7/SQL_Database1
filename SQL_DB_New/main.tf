terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.12.0"
    }
  }
}

provider "azurerm" {
  features {}
}

module "MSSQLServer" {
    source = "./MSSQLServer"
}

module "Log_Analytics_Workspace" {
  source           = "./Log_Analytics_Workspace"
}

module "MSSQLDatabase" {
  source           = "./SQL_Database"
  MSSQLServerName  = module.MSSQLServer.mssql_server_name
}



module "PrivateEndPoint" {
 source = "./Private_Endpoint"
 private_connection_resource_id = module.MSSQLServer.MSSQLServer_ResourceID
 azurerm_mssql_server = module.MSSQLDatabase.azurermmssqlserver
}