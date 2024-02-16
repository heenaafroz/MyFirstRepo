# Create VM interface

resource "azurerm_network_interface" "nic-poc" {
  name                = "support-nic-${var.name}"
  resource_group_name = azurerm_resource_group.poctest.name
  location            = azurerm_resource_group.poctest.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.vm-subnet.id
    private_ip_address_allocation = "Dynamic"    
  }

  #depends_on = [azurerm_subnet.vm-subnet-primary]
}

# Create VM's


resource "azurerm_windows_virtual_machine" "winvm" {
  name                = "winvm-${var.prefix}"
  resource_group_name = azurerm_resource_group.poctest.name
  location            = azurerm_resource_group.poctest.location

  size                = "Standard_B2s"
  admin_username      = "adminuser"
  admin_password      = "Admin@123"


  network_interface_ids = [
    azurerm_network_interface.nic-poc.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "Windows-11"
    sku       = "win11-22h2-avd"
    version   = "latest"
  }

    #depends_on = [
      #azurerm_subnet.vm-subnet-primary,
      #azurerm_network_interface.windows-nic-primary,
    #]
}




#Extension BGInfo
resource "azurerm_virtual_machine_extension" "support-BGInfo" { 
  timeouts {
    create = "120m"
    delete = "120m"
  }
  name                = "support-bginfo-${var.prefix}"
  #resource_group_name = data.azurerm_resource_group.primary.name
  #location            = data.azurerm_resource_group.primary.location
  virtual_machine_id = azurerm_windows_virtual_machine.winvm.id
  publisher            = "Microsoft.Compute"
  type                 = "BGInfo"
  type_handler_version = "2.1"
  depends_on = [azurerm_windows_virtual_machine.winvm]
}


resource "azurerm_virtual_machine_extension" "bootstrap-windows-vm-support-primary" {
  timeouts {
    create = "120m"
    delete = "120m"
  }
  name                       = "support-bootstrap"
  virtual_machine_id         = azurerm_windows_virtual_machine.winvm.id
  publisher                  = "Microsoft.Compute"
  type                       = "CustomScriptExtension"
  type_handler_version       = "1.7"
  auto_upgrade_minor_version = true

 /* protected_settings = <<SETTINGS
  {
    "commandToExecute": "powershell -command \"[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String('${base64encode(data.template_file.file-windows-vm-primary.rendered)}')) | Out-File -filepath bootstrap-support.ps1\" && powershell -ExecutionPolicy Unrestricted -File bootstrap-support.ps1"
  }
  SETTINGS
 */

   lifecycle {
    ignore_changes = [
      tags,
      protected_settings
    ]
  }
  depends_on                   = [azurerm_windows_virtual_machine.winvm]
  
}
/*
data "template_file" "file-windows-vm-support-primary" {
    template = "${file("files/bootstrap-support.ps1")}"
} 
*/
