import java.sql.*;
import java.util.Scanner;

public interface Gestionable {
    /*
    Inserta una tupla en una tabla de la base de datos
     */
    void insert (Connection conn, Scanner sc) throws SQLException;

    /*
    Remueve una tupla en una tabla de la base de datos
     */
    void delete (Connection conn, Scanner sc) throws SQLException;
    
    /*
    Retorna todas las tuplas de la BD
     */
    void printAll (Connection conn) throws SQLException;
}