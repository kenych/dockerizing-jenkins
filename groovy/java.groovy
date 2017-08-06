import hudson.model.JDK
import hudson.tools.InstallSourceProperty
import hudson.tools.ZipExtractionInstaller

def descriptor = new JDK.DescriptorImpl();


def List<JDK> installations = []

javaTools = []

/**
 * uncomment if want to have specific java 8 versions installed, otherwise maven tool will use jenkins default embedded java 8
 * make sure you have these java versions
 * in your download folder
 */
//javaTools=[['name':'jdk8', 'url':'file:/var/jenkins_home/downloads/jdk-8u131-linux-x64.tar.gz', 'subdir':'jdk1.8.0_131']
//        //uncomment to have java 7 as well
//           ,['name':'jdk7', 'url':'file:/var/jenkins_home/downloads/jdk-7u76-linux-x64.tar.gz', 'subdir':'jdk1.7.0_76']
//]

javaTools.each { javaTool ->

    println("Setting up tool: ${javaTool.name}")

    def installer = new ZipExtractionInstaller(javaTool.label as String, javaTool.url as String, javaTool.subdir as String);
    def jdk = new JDK(javaTool.name as String, null, [new InstallSourceProperty([installer])])
    installations.add(jdk)

}
descriptor.setInstallations(installations.toArray(new JDK[installations.size()]))
descriptor.save()
