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


    // Modelos  de zapato que nunca se vendieron
    public static final String CONSULTA_D =
    "SELECT z.modelo, z.color, z.precio " +
    "FROM zapato z " +
    "WHERE (z.modelo, z.color) NOT IN (" +
    "   SELECT df.modelo, df.color " +
    "   FROM detalle_factura df)";

    // Todos los clientes con su tipo
    public static final String CONSULTA_E =
    "SELECT c.DNI, c.nombre, c.apellido, 'Mayorista' AS tipo_cliente " +
    "FROM cliente c " +
    "JOIN mayorista ma ON c.DNI = ma.DNI " +
    "UNION " +
    "SELECT c.DNI, c.nombre, c.apellido, 'Minorista' AS tipo_cliente " +
    "FROM cliente c " +
    "JOIN minorista mi ON c.DNI = mi.DNI ";

    // Modelos de zapato con stock <= 5 junto con su proveedor
    public static final String CONSULTA_F =
    "SELECT zn.modelo, zn.color, zn.numero, zn.stock, p.razon_social, p.telefono_fijo " +
    "FROM zapato_numero zn " +
    "JOIN provee pr ON zn.modelo = pr.modelo AND zn.color = pr.color " +
    "JOIN proveedor p ON pr.CUIT = p.CUIT " +
    "WHERE zn.stock <= 5 ";

    public static final String CONSULTA_G = "";
}
