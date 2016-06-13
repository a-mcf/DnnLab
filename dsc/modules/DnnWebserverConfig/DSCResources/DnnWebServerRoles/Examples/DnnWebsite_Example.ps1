### Example configuration referencing the new composite resource
Configuration aaaaaa {
    
    Import-DscResource -ModuleName DnnWebserverConfig

    Node localhost {

        DnnWebsite bbbbbb {
            property = value
        }

    }
}