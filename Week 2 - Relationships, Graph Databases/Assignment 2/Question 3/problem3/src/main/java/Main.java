import org.neo4j.driver.v1.*;

public class Main {

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
