import groovy.json.JsonSlurper;

def projectsJsonData = new URL("https://pswgithub.rds.lexmark.com/raw/production-engineering/OWASP-Dependancy-Scan/master/config.json").getText()

def organizations = (new JsonSlurper().parseText(projectsJsonData)).organizations
List<Integer> orgNames = new ArrayList<Integer>()
orgNames.add("All") 
organizations.each{ org ->
    orgNames.add(org.name)
}
return orgNames
