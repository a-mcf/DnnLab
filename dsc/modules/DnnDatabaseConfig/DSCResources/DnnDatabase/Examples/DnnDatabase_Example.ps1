### Example configuration referencing the new composite resource
Configuration aaaaaa {
    
    Import-DscResource -ModuleName DnnDatabaseConfig

    Node localhost {

        DnnDatabase bbbbbb {
            property = value
        }

    }
}