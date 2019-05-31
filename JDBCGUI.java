//package jdbcgui;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import javafx.application.*;
import javafx.stage.*;
import javafx.scene.*;
import javafx.scene.control.Button;
import javafx.scene.control.TextArea;
import javafx.scene.layout.VBox;

public class JDBCGUI extends Application {
	String in = "";
	public static void main(String[] args) { //main method
		launch(args);
	}
	
	@Override
	public void start(Stage primaryStage) throws Exception{		//start method for GUI
		primaryStage.setTitle("JDBC Group 1");
		TextArea input = new TextArea();	//Box for query input
		TextArea result = new TextArea();	//Box for query result
		result.setPrefHeight(370); 
		Button go = new Button("Execute");
		go.setOnAction(e ->{		//Do this when button is clicked
			in = input.getText();		//Retrieve query from input TextArea
			result.setText(connect(in));	//Get query results and put into result TextArea
		});
		VBox vb = new VBox(8);
		vb.getChildren().addAll(input, go, result);		//Put GUI together
		Scene scene = new Scene(vb, 1000, 600);
		primaryStage.setScene(scene);
		primaryStage.show();	//Display GUI
	}
	
	public String connect(String t) {		//connect method for connection to database
		String result = "";		//string returned to result TextArea
		int n = 1; //Row count
		String connectionUrl =			//Database we want to connect to
                "jdbc:sqlserver://localhost;"
        		+ "integratedSecurity=true;";
        		
		ResultSet resultSet = null;		//Represents a a result set from our query
        
        try (Connection connection = DriverManager.getConnection(connectionUrl);	//Attempt to establish a connection to database mentioned in connectionURL(SQL Server)
                Statement statement = connection.createStatement();) {		//Statement object that is used to send SQL queries to database

            // Create and execute a SELECT SQL statement.
            String selectSql = t; //t is the string from input TextArea
           
            resultSet = statement.executeQuery(selectSql);		//Sends the input string as a Query to database. If database returns a result, it is stored in resultSet.
            ResultSetMetaData rsmd = resultSet.getMetaData();
            
            // /*Column labels can be commented out 
            int columnsNumber = rsmd.getColumnCount();		//Add Column Labels
            result ="#" + "       ";
            for(int i = 1; i <= columnsNumber; i++) {
            	result = result + rsmd.getColumnName(i) + "       ";
            }	
            result += "\n"; 
            //Column labels can be commented out */
            
            // Print results from select statement
            while (resultSet.next()) {
            	result += n;
            	for(int i = 1; i <= columnsNumber; i++) {
            		result = result + "       " + resultSet.getString(i);
            	}
            	result += "\n";
                n++;
                } 
        }
        
        catch (SQLException e) {
        	e.printStackTrace(); //Catch errors and display 
        }
        return result;
	}
}

