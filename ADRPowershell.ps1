﻿Get-CMSoftwareUpdateAutoDeploymentRule | Select -ExpandProperty UpdateRuleXML
Set-CMSoftwareUpdateAutoDeploymentRule -DateReleasedOrRevised Last6Days