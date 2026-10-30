public class PredefinedQuerys {
    /*
    /Consultas predefinidas
    */

    // Devolver el Nº más vendido por c/modelo de zapatos
    public static final String CONSULTA_A = "";

    // Listado de vendedores con sus ventas totales(monto total) durante 2025.
    public static final String CONSULTA_B = "";

    // Apellido y Nombre de los vendedores que no han tenido francos en enero de 2026.
    public static final String CONSULTA_C = "";


    // Modelos que nunca se vendieron
    public static final String CONSULTA_D =
        "SELECT z.modelo, z.color. z.precio " +
        "FROM zapato z " +
        "WHERE z.modelo NOT IN (" +
        "   SELECT df.modelo " +
        "   FROM detalle_factura df)";

    // Todos los clientes con su tipo
    public static final String CONSULTA_E =
    "SELECT c.DNI, c.nombre, c.apellido, 'Mayorista' AS tipo_cliente " +
    "FROM cliente c " +
    "JOIN mayorista m ON c.DNI = m.DNI" +
    "UNION " +
    "SELECT c.DNI, c.nombre, c.apellido, 'Minorista' AS tipo_cliente " +
    "FROM cliente c " +
    "JOIN minorista m ON c.DNI = mi.DNI";

    public static final String CONSULTA_F = "";
    public static final String CONSULTA_G = "";
}
