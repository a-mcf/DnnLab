### Example configuration referencing the new composite resource
Configuration aaaaaa {
    
    Import-DscResource -ModuleName ScriptResources

    Node localhost {

        ConnectionStrings bbbbbb {
            property = value
        }

    }
}