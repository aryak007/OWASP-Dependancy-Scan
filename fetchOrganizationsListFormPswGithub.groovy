import groovy.json.JsonSlurper; 

def orgNamesList = []

def orgInfo = new URL("https://pswgithub.rds.lexmark.com/api/v3/organizations").getText()

def orgData = (new JsonSlurper().parseText(orgInfo))

for(def org:orgData){
    orgNamesList.add(org.login)
}

return orgNamesList