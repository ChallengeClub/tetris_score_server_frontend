import 'error.dart' as Error;
class EnvironmentVariables {    
    static String apiUrl = const String.fromEnvironment('TETRIS_API') ?? (throw Error.APINotDefinedError());
    static const tetrisFrontendDomain = String.fromEnvironment('TETRIS_FRONTEND_DOMAIN');
}