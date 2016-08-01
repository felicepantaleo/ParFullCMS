//
// ********************************************************************
// * License and Disclaimer                                           *
// *                                                                  *
// * The  Geant4 software  is  copyright of the Copyright Holders  of *
// * the Geant4 Collaboration.  It is provided  under  the terms  and *
// * conditions of the Geant4 Software License,  included in the file *
// * LICENSE and available at  http://cern.ch/geant4/license .  These *
// * include a list of copyright holders.                             *
// *                                                                  *
// * Neither the authors of this software system, nor their employing *
// * institutes,nor the agencies providing financial support for this *
// * work  make  any representation or  warranty, express or implied, *
// * regarding  this  software system or assume any liability for its *
// * use.  Please see the license in the file  LICENSE  and URL above *
// * for the full disclaimer and the limitation of liability.         *
// *                                                                  *
// * This  code  implementation is the result of  the  scientific and *
// * technical work of the GEANT4 collaboration.                      *
// * By using,  copying,  modifying or  distributing the software (or *
// * any work based  on the software)  you  agree  to acknowledge its *
// * use  in  resulting  scientific  publications,  and indicate your *
// * acceptance of all terms of the Geant4 Software license.          *
// ********************************************************************
//
// $Id: G4WentzelVIModel.hh 85306 2014-10-27 14:17:47Z gcosmo $
//
// -------------------------------------------------------------------
//
//
// GEANT4 Class header file
//
//
// File name:     G4WentzelVIModel
//
// Author:        V.Ivanchenko 
//
// Creation date: 09.04.2008 from G4MuMscModel
//
// Modifications:
// 27-05-2010 V.Ivanchenko added G4WentzelOKandVIxSection class to
//              compute cross sections and sample scattering angle
//
// Class Description:
//
// Implementation of the model of multiple scattering based on
// G.Wentzel, Z. Phys. 40 (1927) 590.
// H.W.Lewis, Phys Rev 78 (1950) 526.
// J.M. Fernandez-Varea et al., NIM B73 (1993) 447.
// L.Urban, CERN-OPEN-2006-077.

// -------------------------------------------------------------------
//

#ifndef G4WentzelVIModel_h
#define G4WentzelVIModel_h 1

//....oooOO0OOooo........oooOO0OOooo........oooOO0OOooo........oooOO0OOooo......

#include "G4VMscModel.hh"
#include "G4MaterialCutsCouple.hh"
#include "G4WentzelOKandVIxSection.hh"

//....oooOO0OOooo........oooOO0OOooo........oooOO0OOooo........oooOO0OOooo......

class G4WentzelVIModel : public G4VMscModel
{

public:

  G4WentzelVIModel(G4bool comb = true, const G4String& nam = "WentzelVIUni");

  virtual ~G4WentzelVIModel();

  virtual void Initialise(const G4ParticleDefinition*, const G4DataVector&);

  virtual void InitialiseLocal(const G4ParticleDefinition*, 
                               G4VEmModel* masterModel);

  void StartTracking(G4Track*);

  virtual G4double ComputeCrossSectionPerAtom(const G4ParticleDefinition*,
					      G4double KineticEnergy,
					      G4double AtomicNumber,
					      G4double AtomicWeight=0., 
					      G4double cut = DBL_MAX,
					      G4double emax= DBL_MAX);

  virtual G4ThreeVector& SampleScattering(const G4ThreeVector&, 
					  G4double safety);

  virtual G4double ComputeTruePathLengthLimit(const G4Track& track,
					      G4double& currentMinimalStep);

  virtual G4double ComputeGeomPathLength(G4double truePathLength);

  virtual G4double ComputeTrueStepLength(G4double geomStepLength);

  // defines low energy limit on energy transfer to atomic electron
  inline void SetFixedCut(G4double);

  // low energy limit on energy transfer to atomic electron
  inline G4double GetFixedCut() const;

  // access to cross section class
  inline G4WentzelOKandVIxSection* GetWVICrossSection();

  inline void SetUseSecondMoment(G4bool);

  inline G4bool UseSecondMoment() const;

  inline G4PhysicsTable* GetSecondMomentTable();

  inline G4double SecondMoment(const G4ParticleDefinition*,
			       const G4MaterialCutsCouple*,
			       G4double kineticEnergy);

  void SetSingleScatteringFactor(G4double);

protected:

  inline void DefineMaterial(const G4MaterialCutsCouple*);

private:

  G4double ComputeTransportXSectionPerVolume(G4double cosTheta);

  G4double ComputeSecondMoment(const G4ParticleDefinition*,
			       G4double kineticEnergy);

  inline void SetupParticle(const G4ParticleDefinition*);

  //  hide assignment operator
  G4WentzelVIModel & operator=(const  G4WentzelVIModel &right);
  G4WentzelVIModel(const  G4WentzelVIModel&);

protected:

  G4WentzelOKandVIxSection* wokvi;

  G4double tlimitminfix;
  G4double ssFactor;
  G4double invssFactor;

  // cache kinematics
  G4double preKinEnergy;
  G4double tPathLength;
  G4double zPathLength;
  G4double lambdaeff;
  G4double currentRange; 
  G4double cosTetMaxNuc;

  // cache material
  G4int    currentMaterialIndex;
  const G4MaterialCutsCouple* currentCouple;
  const G4Material* currentMaterial;

  const G4ParticleDefinition* particle;

  // flags
  G4bool   inside;
  G4bool   singleScatteringMode;

private:

  G4ParticleChangeForMSC*   fParticleChange;
  const G4DataVector*       currentCuts;

  G4double invsqrt12;
  G4double fixedCut;

  // cache kinematics
  G4double effKinEnergy;

  // single scattering parameters
  G4double cosThetaMin;
  G4double cosThetaMax;

  G4PhysicsTable* fSecondMoments;
  size_t          idx2;

  // data for single scattering mode
  G4double xtsec;
  std::vector<G4double> xsecn;
  std::vector<G4double> prob;
  G4int    nelments;

  G4double numlimit;

  // projectile
  G4double lowEnergyLimit;

  // flags
  G4bool   isCombined;
  G4bool   useSecondMoment;
};

//....oooOO0OOooo........oooOO0OOooo........oooOO0OOooo........oooOO0OOooo......
//....oooOO0OOooo........oooOO0OOooo........oooOO0OOooo........oooOO0OOooo......

inline
void G4WentzelVIModel::DefineMaterial(const G4MaterialCutsCouple* cup) 
{ 
  if(cup != currentCouple) {
    currentCouple = cup;
    SetCurrentCouple(cup); 
    currentMaterial = cup->GetMaterial();
    currentMaterialIndex = currentCouple->GetIndex(); 
  }
}

//....oooOO0OOooo........oooOO0OOooo........oooOO0OOooo........oooOO0OOooo....

inline void G4WentzelVIModel::SetupParticle(const G4ParticleDefinition* p)
{
  // Initialise mass and charge
  if(p != particle) {
    particle = p;
    wokvi->SetupParticle(p);
  }
}

//....oooOO0OOooo........oooOO0OOooo........oooOO0OOooo........oooOO0OOooo....

inline void G4WentzelVIModel::SetFixedCut(G4double val)
{
  fixedCut = val;
}

//....oooOO0OOooo........oooOO0OOooo........oooOO0OOooo........oooOO0OOooo....

inline G4double G4WentzelVIModel::GetFixedCut() const
{
  return fixedCut;
}

//....oooOO0OOooo........oooOO0OOooo........oooOO0OOooo........oooOO0OOooo....

inline G4WentzelOKandVIxSection* G4WentzelVIModel::GetWVICrossSection()
{
  return wokvi;
}

//....oooOO0OOooo........oooOO0OOooo........oooOO0OOooo........oooOO0OOooo....

inline void G4WentzelVIModel::SetUseSecondMoment(G4bool val)
{
  useSecondMoment = val;
}

//....oooOO0OOooo........oooOO0OOooo........oooOO0OOooo........oooOO0OOooo....

inline G4bool G4WentzelVIModel::UseSecondMoment() const
{
  return useSecondMoment;
}

//....oooOO0OOooo........oooOO0OOooo........oooOO0OOooo........oooOO0OOooo....

inline G4PhysicsTable* G4WentzelVIModel::GetSecondMomentTable()
{
  return fSecondMoments;
}

//....oooOO0OOooo........oooOO0OOooo........oooOO0OOooo........oooOO0OOooo....

inline G4double 
G4WentzelVIModel::SecondMoment(const G4ParticleDefinition* part,
			       const G4MaterialCutsCouple* couple,
			       G4double ekin)
{
  G4double x = 0.0;
  if(useSecondMoment) { 
    DefineMaterial(couple);
    if(fSecondMoments) { 
      x = (*fSecondMoments)[(*theDensityIdx)[currentMaterialIndex]]
	->Value(ekin, idx2)
	*(*theDensityFactor)[currentMaterialIndex]/(ekin*ekin);
    } else {
      x = ComputeSecondMoment(part, ekin);
    }
  }
  return x;
}

//....oooOO0OOooo........oooOO0OOooo........oooOO0OOooo........oooOO0OOooo......

#endif

