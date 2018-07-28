/*
 *  Add all the actors and the roles they played in this movie “John Wick” to the database using JAVA REST API
 *  or some other APIs for Neo4J in a language of your choice (not Curl). 
 *  Demonstrate that you have successfully brought data about John Wick movie into the database
 *  
 *  @author: Karan Bhandarkar
*/
package neo4j.samples;

import org.neo4j.driver.v1.*;

public class Q5 {

	private static final String DB_PATH = "C:\\Users\\kbhandarkar\\Documents\\Neo4j\\new.graphdb";
	
	private static final String actorExportQueryString = "CALL apoc.export.csv.query(\"MATCH (p:Actor)-[r]->(m:Movie) return p.name as name,"
			+ " type(r) as type, r.role as role, m.title as title,"
			+ " m.year as year\", \"C:/Users/kbhandarkar/Documents/Neo4j/default.graphdb/import/Actor.csv\", {})";
	
	private static final String directorExportQueryString = "CALL apoc.export.csv.query(\"MATCH (p:Director)-[r]->(m:Movie) return p.name as name,"
			+ " type(r) as type, m.title as title, m.year as year\","
			+ " \"C:/Users/kbhandarkar/Documents/Neo4j/default.graphdb/import/Director.csv\", {})";

	private static final String deleteQueryString = "MATCH (n) OPTIONAL MATCH (n)-[r]-() DETACH DELETE n,r";
	
	private static final String actorImportQueryString = "LOAD CSV WITH HEADERS FROM \"file:///Actor.csv\" AS row " + 
			"MERGE (m:Movie {title:row.title}) ON CREATE SET m.year = row.year " + 
			"MERGE (a:Actor {name:row.name}) " + 
			"FOREACH (_ in CASE row.type WHEN \"ACTS_IN\" then [1] else [] end | " + 
			"   MERGE (a)-[r:ACTS_IN]->(m) ON CREATE SET r.role = row.role " + 
			") ";
	
	private static final String directorImportQueryString = "LOAD CSV WITH HEADERS FROM \"file:///Director.csv\" AS row " + 
			"MERGE (m:Movie {title:row.title}) ON CREATE SET m.year = row.year " + 
			"MERGE (a:Director{name:row.name}) " + 
			"FOREACH (_ in CASE row.type WHEN \"DIRECTED\" then [1] else [] end | " + 
			"   MERGE (a)-[r:DIRECTED]->(m)  " + 
			") ";
   
	public static void main(String[] args) {
        
    	Driver driver = null;
    	Session session = null;
    	try {
    		driver = GraphDatabase.driver( "bolt://localhost", AuthTokens.basic( "neo4j", "M@nchesterUn7ted" ));
            session = driver.session();

            System.out.println("Export the movies database into Actor.csv and Director.csv files");
            session.run(actorExportQueryString);
            session.run(directorExportQueryString);

            System.out.println("Delete the contents of the database");
            session.run(deleteQueryString);
            
            System.out.println("Import the contents of the .csv");
            session.run(actorImportQueryString);
            System.out.println("Actors imported to DB with their movies");
            session.run(directorImportQueryString);
            System.out.println("Directors imported to DB with their movies");
            
    	} catch (Exception e) {
    		System.out.println(e);
    	} finally {
    		session.close();
            driver.close();
    	}
    }

}
