/*
 *  Add all the actors and the roles they played in this movie “John Wick” to the database using JAVA REST API
 *  or some other APIs for Neo4J in a language of your choice (not Curl). 
 *  Demonstrate that you have successfully brought data about John Wick movie into the database
 *  
 *  @author: Karan Bhandarkar
*/
package neo4j.samples;
import org.neo4j.driver.v1.*;

public class Q3 {

    public static void main(String[] args) {
        
    	String queryString = "MATCH(keanu:Actor{name:'Keanu Reeves'}) "+
    							"CREATE (johnwick:Movie { title : 'John Wick'}) " +
    							"CREATE (keanu)-[:ACTS_IN { role : 'John Wick' }]->(johnwick) "+
    							"CREATE (:Actor { name:'Michael Nyqvist' })-[:ACTS_IN { role : 'Viggo Tarasov' }]->(johnwick) " + 
    							"CREATE (:Actor { name:'Alfie Allen' })-[:ACTS_IN { role : 'Iosef Tarasov' }]->(johnwick) ";
    	
    	String responseString = "MATCH (actor:Actor)-[r:ACTS_IN]->(movie:Movie { title : 'John Wick'}) "
    			+ "return movie.title as Movie, actor.name as Actor, r.role as Role" ;
    		
    	Driver driver = null;
    	Session session = null;
    	try {
    		driver = GraphDatabase.driver( "bolt://localhost", AuthTokens.basic( "neo4j", "M@nchesterUn7ted" ));
            session = driver.session();

            session.run(queryString);
            StatementResult result = session.run(responseString);
            
            while (result.hasNext())
            {
                Record record = result.next();
                System.out.println( "Attached actor "+record.get( "Actor" ).asString() + " to movie " 
                + record.get("Movie").asString() + " as "+ record.get("Role").asString());
                
            }
    	} catch (Exception e) {
    		
    	} finally {
    		session.close();
            driver.close();
    	}
    }

}
