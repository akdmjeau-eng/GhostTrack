#include <sys/mman.h>
#include <iostream>

class MemoryOptimizer {
public:
    static void configureAccessPattern(void* mappedRegion, size_t length, bool isSequential) {
        int advice = isSequential ? MADV_SEQUENTIAL : MADV_RANDOM;
        
        if (madvise(mappedRegion, length, advice) < 0) {
            perror("[Kernel] Error al aplicar madvise");
        } else {
            std::cout << "[Kernel] Patron de memoria configurado como: " 
                      << (isSequential ? "Secuencial (Read-Ahead)" : "Aleatorio (No-Read-Ahead)") 
                      << std::endl;
        }
    }
};
