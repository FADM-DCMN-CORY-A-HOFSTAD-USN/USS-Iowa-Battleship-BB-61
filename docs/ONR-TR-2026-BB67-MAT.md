## **Department of the Navy | Office of Naval Research (ONR)**

**Technical Report Directive:** ONR-TR-2026-BB67-MAT  
**Subject:** Manufacturing Specification for Elastomer-Infiltrated Composite Metal Foams (E-CMF) as High-Energy Blast Mitigation Armor  
**Primary Materials:** High-Purity Aluminum ($\\text{Al}$), Titanium ($\\text{Ti}$), and Cross-Linked Natural Rubber ($\\text{NR}$) Elastomer Matrices.

## ---

**1\. Executive Summary & Design Paradigm**

This report outlines the industrial production pipeline for **Elastomer-Infiltrated Composite Metal Foams (E-CMF)** for heavy hull shielding applications. By moving away from brittle, monolithic armor plates, this design relies on a dual-phase material system: a **rigid, open-cell metallic skeleton** that absorbs initial kinetic energy via micro-strut crushing, and an **interpenetrating natural rubber network** that dampens shockwaves and rebounds after deformation.

When scaled to a thick outer hull layer, this material creates a highly buoyant geometric profile—ideal for heavy-duty, protective marine assets.

## ---

**2\. Multi-Phase Material Selection & Properties**

The metallic skeleton can be manufactured using either **Aluminum (Al-Alloy)** for lightweight, cost-effective energy damping or **Titanium (Ti-6Al-4V)** for extreme ballistic resistance. The infiltrating phase consists of a customized natural rubber formulation optimized for high-pressure injection.

| Material Phase Component | Density ($\\rho$, $\\text{g/cm}^3$) | Tensile Strength ($\\sigma\_{ts}$, $\\text{MPa}$) | Primary Structural Role |
| :---- | :---- | :---- | :---- |
| **Aluminum Skeleton (Al-Mg Alloy)** | 2.70 (Solid) / 0.35 (Foamed) | 220–310 | Low-mass kinetic energy absorption via plastic cell deformation. |
| **Titanium Skeleton (Ti-6Al-4V)** | 4.43 (Solid) / 0.72 (Foamed) | 950–1050 | High-velocity projectile fragmentation & shear mitigation. |
| **Natural Rubber Elastomer (NR)** | 0.92–0.95 | 25–35 | Hyperelastic shock damping & cell rebound optimization. |

## ---

**3\. Open-Cell Metallic Skeleton Manufacturing**

The rigid skeleton is manufactured using a modified **Direct Melt Gas Injection** process using **Nitrogen ($\\text{N}\_2$)** as the primary blowing agent.

`[Gas Injection System] ---> (N2 Gas at 1.2 MPa)`   
                                   `|`  
                                   `v`  
`[Induction Furnace] --------> [Molten Metal Pool] + (Thickeners: SiC/Al2O3)`  
                                   `|`  
                                   `v`  
`[Precision Cooling Line] ---> [Open-Cell Porous Metallic Skeleton]`

## **3.1 Slurry Thickening and Viscosity Control**

Before gas injection, the molten metal pool must be stabilized to prevent the immediate collapse of the cell walls.

> *   
> * For **Aluminum ($720^\\circ\\text{C}$)**: Add $15\\,\\text{wt}\\%$ Calcium ($\\text{Ca}$) or Silicon Carbide ($\\text{SiC}$) particles.  
> * For **Titanium ($1700^\\circ\\text{C}$)**: Mix with $10\\,\\text{wt}\\%$ Aluminum Oxide ($\\text{Al}\_2\\text{O}\_3$) particles under vacuum induction melting to ensure uniform cell wall surface tension.  
> * 

## **3.2 Nitrogen ($\\text{N}\_2$) Gas Injection Dynamics**

Nitrogen gas is introduced through an array of rotating ceramic impellers submerged at the bottom of the melt. The gas flow rate is regulated based on the required final porosity:  
$$\\Phi \= 1 \- \\left( \\frac{\\rho\_{\\text{foam}}}{\\rho\_{\\text{solid}}} \\right)$$

The relationship between foaming temperature and resulting cell diameter ($D\_c$) must be monitored to ensure an optimal open-cell matrix:

`Cell Diameter Dc (microns)`  
  `^`  
`150 |       /`  
`120 |      /  <-- Inefficient (Closed Pores)`  
 `90 |     /`  
 `60 |    /____  <-- Optimal Target Zone (60-80 µm Open Pores)`  
 `30 |  /`  
  `0 +--------------------------------------->`  
    `1550   1600   1650   1700   1750   1800`  
         `Melting Temperature (T °C for Titanium)`

## ---

**4\. Pressure-Assisted Elastomer Infiltration Pipeline**

Once the open-cell metal foam has solidified and cooled, the residual skin is acid-etched to open any remaining surface pores. The block is then transferred to a high-pressure autoclave for **Polymer Infiltration Synthesis (PIS)**.

## **4.1 Natural Rubber Pre-Polymer Compound**

The rubber infiltration matrix uses a low-viscosity liquid natural rubber pre-polymer:

> *   
> * **Base:** Cis-1,4-polyisoprene  
> * **Vulcanizing Agent:** $2.5\\,\\text{wt}\\%$ Elemental Sulfur ($\\text{S}\_8$)  
> * **Accelerator:** Zinc Oxide ($\\text{ZnO}$) mixed with stearic acid.  
> * 

## **4.2 Vacuum-Pressure Infiltration Cycle**

To eliminate internal air trapping and ensure an **Infiltration Efficiency $\\ge 88\\%$**, a four-step mechanical process is mandatory:

> 1. **Chamber Evacuation:** The open-cell metal skeleton is placed in the mold cavity and drawn down to a vacuum of $\\le 10^{-2}\\,\\text{Torr}$ for 45 minutes to evacuate all internal pore channels.  
> 2. **Liquid Injection:** The liquid rubber mixture is introduced into the bottom of the mold under vacuum, completely submerging the metallic preform.  
> 3. **Autoclave Overpressure:** The chamber is pressurized with dry Argon gas to **$1.5\\,\\text{MPa}$**, forcing the elastomer deep into the micro-porosities of the metal cell walls.  
> 4. **Thermal Vulcanization:** The internal temperature is elevated to **$145^\\circ\\text{C}$** for 120 minutes while maintaining clamping force to cure the cross-linked rubber matrix natively within the metal struts.

## ---

**5\. Mechanical Performance & Blast Response**

The primary defensive advantage of E-CMF armor lies in its **Specific Energy Absorption (SEA)** under extreme dynamic loads.

`Compressive Stress (Sigma)`  
  `^`  
  `|      _______  <-- Extended Plateau Region (Metal Strut Crushing)`

  `|    /|       |\`  
  `|   / |       | \  <-- Densification & Elastomer Rebound`  
  `|  /  |       |  \___________`  
  `| /   |       |              \`  
  `0+--------------------------------------->`  
   `0   0.2     0.4     0.6    0.8     1.0`  
             `Compressive Strain (Strain)`

The total energy absorbed per unit volume ($W$) is calculated during impact by integrating the stress-strain curve:  
$$W \= \\int\_{0}^{\\epsilon\_d} \\sigma(\\epsilon) \\, d\\epsilon$$  
Where $\\epsilon\_d$ represents the densification strain limit where the internal rubber cells are completely compressed. The interpenetrating rubber network keeps the compressed metal struts confined, preventing the armor from cracking or falling away during secondary impacts.

## ---

**6\. Trusted Official Resources & References**

> 1. **National Center for Biotechnology Information (NCBI / NIH):** *A Review of Different Manufacturing Methods of Metallic Foams* (PMCID: PMC10870358) — Process details on melt gas injection and gas bubbling thermodynamics.  
> 2. **NASA Technical Reports Server (NTRS):** *Polymer Infused Composite Metal Foam as a Potential Aircraft Component* (Document ID: 20190031917\) — Data on vacuum infiltration procedures, resin retention metrics, and 88% infusion efficiency standards.  
> 3. **National Science Foundation (NSF) Public Access Repository:** *Robust Bicontinuous Elastomer–Metal Foam Composites* (Award Id: 10353325\) — Production guidelines for pressure-assisted liquid rubber infiltration into open-cell metallic networks.  
> 4. **Defense Technical Information Center (DTIC):** *Bio-inspired Armor Protective Material Systems for Ballistic and Blast Mitigation* (Accession Number: ADA543984) — Multi-phase structural performance under high dynamic blast impacts.  
> 5. **Department of Transportation (PHMSA):** *Metal Foams for Impact Mitigation and Shock Absorption* — Performance parameters detailing progressive cell wall deformation under heavy ballistic loads.

