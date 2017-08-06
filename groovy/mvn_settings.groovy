import jenkins.model.*
import org.jenkinsci.plugins.configfiles.maven.*
import org.jenkinsci.plugins.configfiles.maven.security.*

def configStore = Jenkins.instance.getExtensionList('org.jenkinsci.plugins.configfiles.GlobalConfigFiles')[0]

println("Setting maven settings xml")
def serverCreds = new ArrayList()


//server id as in your pom file
def serverId = 'artifactory'

//credentialId from credentials.groovy
def credentialId = 'artifactoryCredentials'

serverCredentialMapping = new ServerCredentialMapping(serverId, credentialId)
serverCreds.add(serverCredentialMapping)


def configId =  'our_settings'
def configName = 'myMavenConfig for jenkins automation example'
def configComment = 'Global Maven Settings'
def configContent  = '''<settings>
<!-- your maven settings goes here -->
</settings>'''


def globalConfig = new GlobalMavenSettingsConfig(configId, configName, configComment, configContent, true, serverCreds)
configStore.save(globalConfig)

println("maven settings complete")
