import groovy.json.JsonSlurper; 

def fetchRepoList(def orgName){
def pageNo = 1
    def pswgithubPath  = "pswgithub.rds.lexmark.com"
    def repositoryList = []
        try{
            while(true){
                def reposData = new URL("https://"+pswgithubPath+"/api/v3/orgs/"+orgName+"/repos?page="+"${pageNo}").getText()
                def reposDataJson = (new JsonSlurper().parseText(reposData))
                            if(reposDataJson.empty){
                                println "Scanning done for Organization "+orgName
                                throw new Exception()
                            }
                            
                            for(def repo:reposDataJson){
                                repositoryList.add(repo.name)
                            }
                            pageNo++
                    }
            }
            
            catch (Exception e){
                return repositoryList
        }
}
return fetchRepoList(ORGANIZATION_NAME)