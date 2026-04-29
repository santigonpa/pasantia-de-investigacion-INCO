# Modelos de comunicación inalámbrica para flotas de robots

Código desarrollado en el contexto de la pasantía de investigación en el [Instituto de Computación (INCO)](https://www.fing.edu.uy/inco/) de la Facultad de Ingeniería, Universidad de la República (Uruguay).

> **Wireless communication models for robot fleets** — MATLAB/Octave scripts for modeling and visualizing signal propagation in indoor environments represented as occupancy grids.

---

## Descripción

Este repositorio contiene scripts de MATLAB/Octave que implementan y comparan diferentes **modelos de propagación de señal inalámbrica** (2.4 GHz) aplicados a entornos interiores. El objetivo es generar **mapas de comunicación** (communication maps) que cuantifican la pérdida de señal entre pares de celdas libres en un plano, lo que permite estimar la calidad del enlace entre robots ubicados en distintas posiciones del entorno.

Los entornos se representan como **occupancy grids** (cuadrículas de ocupación), donde `0` indica celda libre y `1` indica obstáculo/pared.

---

## Modelos implementados

### Free Space Path Loss (FSPL)
Modelo de referencia que calcula la pérdida de señal en el espacio libre en función de la distancia y la frecuencia:

```
PL = 20·log10(d) + 20·log10(f) + 20·log10(4π/c)
```

### Motley-Keenan Model (MKM)
Extiende el FSPL añadiendo la atenuación producida por las paredes que interceptan la línea de visión entre dos puntos. El número de paredes se determina usando el **algoritmo de Bresenham** (`bresenham_line.m`):

```
PL_MKM = PL_FSPL + n_paredes · L_pared
```

### Wall Attenuation Factor Model (WAF)
Variante del modelo de pérdida que combina un exponente de propagación ajustado con la atenuación por paredes.

### Rayleigh Fading
Modelo estocástico que añade desvanecimiento multipercurso a la pérdida en espacio libre, modelando variaciones aleatorias de la señal.

---

## Escenarios

### Escenario de prueba (plano simple)
Occupancy grid de 5 × 17 celdas con habitaciones separadas por paredes.

### Escenario doble (plano ampliado)
Occupancy grid de 10 × 34 celdas (resolución de celda: 0.5 m/celda).

### Plano del INCO
Plano real del piso del Instituto de Computación representado como un occupancy grid de 8 × 60 celdas (resolución: 1.235 m/celda), con paredes de tipo *steel frame + yeso* (L_wall = 13.86 dB).

---

## Descripción de archivos

### Utilidades

| Archivo | Descripción |
|---|---|
| `bresenham_line.m` | Implementación del algoritmo de Bresenham para trazar líneas en una cuadrícula. Utilizado para contar el número de paredes entre dos celdas. |

### Comparación de modelos

| Archivo | Descripción |
|---|---|
| `Rayleigh.m` | Genera y grafica el desvanecimiento Rayleigh sumado al FSPL. |
| `FSPL_VS_RAYLEIGH.m` | Compara gráficamente el FSPL con el modelo FSPL + Rayleigh Fading. |
| `FSPL_VS_MKM_PAREDES.m` | Compara el FSPL, el modelo MKM y el modelo WAF en presencia de paredes a distancias fijas. |

### Mapas de comunicación — Escenario de prueba (plano simple, 5 × 17)

| Archivo | Modelo | Descripción |
|---|---|---|
| `commMapPlano.m` | FSPL | Mapa de comunicación del escenario de prueba usando FSPL. |
| `commMapPlanoMKM.m` | MKM | Mapa de comunicación del escenario de prueba usando MKM con conteo de paredes. |

### Mapas de comunicación — Escenario doble (10 × 34)

| Archivo | Modelo | Descripción |
|---|---|---|
| `commMapPlanoDoble.m` | FSPL | Mapa de comunicación del escenario ampliado usando FSPL. |
| `commMapPlanoDobleMKM.m` | MKM | Mapa de comunicación del escenario ampliado usando MKM. |

### Mapas de comunicación — Plano del INCO (8 × 60)

| Archivo | Modelo | Descripción |
|---|---|---|
| `commMapPlanoInco.m` | FSPL | Mapa de comunicación del plano del INCO usando FSPL. |
| `commMapPlanoIncoMKM.m` | MKM | Mapa de comunicación del plano del INCO usando MKM (L_wall = 13.86 dB). |
| `commMapPlanoIncoDoble.m` | FSPL | Versión de prueba / variante del mapa FSPL del INCO. |
| `commMapPlanoIncoDobleMKM.m` | MKM | Versión de prueba / variante del mapa MKM del INCO. |

### Visualización por celda de origen

| Archivo | Descripción |
|---|---|
| `commMapT.m` | Mapa de comunicación sobre un grid de 4 × 4 celdas de ejemplo. |
| `mapEnFuncionDeUnaCelda.m` | Visualiza la pérdida de señal desde una celda origen fija en el escenario de prueba. |
| `mapEnFuncionDeUnaCeldaDoble.m` | Ídem para el escenario doble. |
| `mapEnFuncionDeUnaCeldaInco.m` | Ídem para el plano del INCO. |
| `mapEnFuncionDeUnaCeldaIncoDoble.m` | Ídem para la variante doble del plano del INCO. |

---

## Requisitos

- **MATLAB** (R2016b o superior) o **GNU Octave** (4.x o superior).
- No se requieren toolboxes adicionales (las funciones `raylrnd` / `rand` de base son suficientes).

> **Nota:** `bresenham_line.m` usa la sintaxis `+=` y `endif`/`endfor` propia de Octave. En MATLAB puro puede requerir ajustes menores.

---

## Uso

1. Abrir MATLAB u Octave.
2. Establecer el directorio de trabajo en la raíz del repositorio.
3. Para comparar modelos de propagación, ejecutar cualquiera de los scripts de comparación:
   ```matlab
   run('FSPL_VS_MKM_PAREDES.m')
   run('FSPL_VS_RAYLEIGH.m')
   ```
4. Para generar un mapa de comunicación completo, ejecutar el script correspondiente al escenario y modelo deseado. Por ejemplo:
   ```matlab
   run('commMapPlanoIncoMKM.m')
   ```
5. Para visualizar la pérdida desde una celda específica, primero ejecutar el script del mapa correspondiente y luego el script `mapEnFuncionDeUnaCelda*.m`.

---

## Contexto académico

Este trabajo fue desarrollado como parte de la **pasantía de investigación** en el Instituto de Computación (INCO), Facultad de Ingeniería, Universidad de la República — Uruguay.

**Tema:** *Modelos de comunicación inalámbrica para flotas de robots*

El objetivo general es proveer herramientas para evaluar la calidad de los enlaces de comunicación entre robots móviles en entornos interiores, como paso previo a la planificación de misiones cooperativas.
