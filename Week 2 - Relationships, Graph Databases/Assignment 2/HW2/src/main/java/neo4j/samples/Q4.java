/*
 *  Find a list of actors playing in movies in which Keanu Reeves played. 
 *  Find directors of movies in which K. Reeves played.
 *   
 *  @author: Karan Bhandarkar
*/
package neo4j.samples;
import org.neo4j.driver.v1.*;

public class Q4 {

    public static void main(String[] args) {
    	
    	String celebrityQueryString = "MATCH (keanu:Actor{name:\"Keanu Reeves\"}) " + 
    			"MATCH (keanu)-[:ACTS_IN]->(keanuMovies) " + 
    			"MATCH (keanuMovieActor)-[r:ACTS_IN]->(keanuMovies) WHERE keanuMovieActor.name <> keanu.name " + 
    			"RETURN distinct keanuMovieActor.name AS Celebrity,'Actor' as Contribution, r.role as Role " + 
    			"UNION " + 
    			"MATCH (keanuMovieDirector)-[r:DIRECTED]->(keanuMovies) " + 
    			"RETURN distinct keanuMovieDirector.name AS Celebrity,'Director' as Contribution, null as Role";
    	
    	String completeRelationQueryString = "MATCH (keanu:Actor{name:\"Keanu Reeves\"}) " + 
    							"MATCH (keanu)-[:ACTS_IN]->(keanuMovies) " + 
    							"MATCH (keanuMovieCelebs)-[r]->(keanuMovies) WHERE keanuMovieCelebs.name <> keanu.name " + 
    							"RETURN distinct keanuMovieCelebs.name AS CelebName, r.role AS RoleName, keanuMovies.title AS MovieName";

    	Driver driver = null;
    	Session session = null;
    	try {
    		driver = GraphDatabase.driver( "bolt://localhost", AuthTokens.basic( "neo4j", "M@nchesterUn7ted" ));
            session = driver.session();

            System.out.println("List of actors that played in movies and directors that directed movies staring Keanu Reeves:");
            
            StatementResult celebrity = session.run(celebrityQueryString);
            
            while (celebrity.hasNext())
            {
                Record celebRecord = celebrity.next();
                StringBuilder sb1  = new StringBuilder();
                if((celebRecord.get("Contribution").asString()).equalsIgnoreCase("Actor")) {
                	sb1.append(celebRecord.get("Celebrity") + " acted in a movie with Keanu Reeves");
                } else {
                	sb1.append(celebRecord.get("Celebrity") + " directed a movie starring Keanu Reeves");
                }
                System.out.println(sb1.toString());
            }
            
            System.out.println("Detailed Relationships: ");
            
            StatementResult completeRelation = session.run(completeRelationQueryString);
            
            while (completeRelation.hasNext())
            {
                Record record = completeRelation.next();
                StringBuilder sb  = new StringBuilder();
                sb.append("Retrieved "+record.get( "CelebName" ).asString()+" who ");
                if(!(record.get( "RoleName" ).asString()).equalsIgnoreCase("null")) {
                	sb.append("played the role of " + record.get( "RoleName" ).asString() + " in ");
                } else {
                	sb.append("directed ");
                }
                sb.append("the movie " + record.get( "MovieName" ).asString() + " starring Keanu Reeves");
                System.out.println(sb.toString());
            }
    	} catch (Exception e) {
    		
    	} finally {
    		session.close();
            driver.close();
    	}
    }

}
