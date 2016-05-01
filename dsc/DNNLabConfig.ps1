Configuration DNNLabConfig
{
    file DemoFile
    {
        ensure = "Present"
        Contents = $ConfigurationData.NonNodeData.FileText
        DestinationPath = "c:\file.txt"
    }
}