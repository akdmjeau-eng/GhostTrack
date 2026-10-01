#include <unistd.h>
#include <sys/wait.h>
#include <vector>

class AndroidDeviceController {
public:
    static bool executeFastbootCommand(const std::vector<std::string>& args) {
        pid_t pid = fork();
        
        if (pid == 0) { // Proceso hijo
            // Preparar argumentos para execvp
            std::vector<char*> c_args;
            c_args.push_back(const_cast<char*>("fastboot"));
            for (const auto& arg : args) {
                c_args.push_back(const_cast<char*>(arg.c_str()));
            }
            c_args.push_back(nullptr);

            execvp("fastboot", c_args.data());
            // Si execvp falla, termina el proceso hijo inmediatamente
            _exit(EXIT_FAILURE);
        } else if (pid > 0) { // Proceso padre
            int status;
            waitpid(pid, &status, 0);
            return WIFEXITED(status) && WEXITSTATUS(status) == 0;
        }
        return false;
    }
};

// Uso conceptual:
// AndroidDeviceController::executeFastbootCommand({"flashing", "unlock"});
