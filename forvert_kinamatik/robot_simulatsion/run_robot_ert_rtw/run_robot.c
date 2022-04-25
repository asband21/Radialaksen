/*
 * run_robot.c
 *
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Code generation for model "run_robot".
 *
 * Model version              : 1.1
 * Simulink Coder version : 9.6 (R2021b) 14-May-2021
 * C source code generated on : Thu Apr  7 09:38:48 2022
 *
 * Target selection: ert.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Atmel->AVR
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include "run_robot.h"
#include "run_robot_private.h"

/* Block states (default storage) */
DW_run_robot_T run_robot_DW;

/* Real-time model */
static RT_MODEL_run_robot_T run_robot_M_;
RT_MODEL_run_robot_T *const run_robot_M = &run_robot_M_;
real_T rt_roundd_snf(real_T u)
{
  real_T y;
  if (fabs(u) < 4.503599627370496E+15) {
    if (u >= 0.5) {
      y = floor(u + 0.5);
    } else if (u > -0.5) {
      y = u * 0.0;
    } else {
      y = ceil(u - 0.5);
    }
  } else {
    y = u;
  }

  return y;
}

/* Model step function */
void run_robot_step(void)
{
  real_T tmp_0;
  uint8_T tmp;

  /* MATLABSystem: '<Root>/Standard Servo Write' incorporates:
   *  Constant: '<S1>/Vector'
   *  MultiPortSwitch: '<S1>/Output'
   *  UnitDelay: '<S2>/Output'
   */
  if (run_robot_P.RepeatingSequenceStair_OutValue[run_robot_DW.Output_DSTATE] <
      0.0) {
    tmp = 0U;
  } else if
      (run_robot_P.RepeatingSequenceStair_OutValue[run_robot_DW.Output_DSTATE] >
       180.0) {
    tmp = 180U;
  } else {
    tmp_0 = rt_roundd_snf
      (run_robot_P.RepeatingSequenceStair_OutValue[run_robot_DW.Output_DSTATE]);
    if (tmp_0 < 256.0) {
      if (tmp_0 >= 0.0) {
        tmp = (uint8_T)tmp_0;
      } else {
        tmp = 0U;
      }
    } else {
      tmp = MAX_uint8_T;
    }
  }

  MW_servoWrite(0, tmp);

  /* End of MATLABSystem: '<Root>/Standard Servo Write' */

  /* Sum: '<S3>/FixPt Sum1' incorporates:
   *  Constant: '<S3>/FixPt Constant'
   *  UnitDelay: '<S2>/Output'
   */
  run_robot_DW.Output_DSTATE += run_robot_P.FixPtConstant_Value;

  /* Switch: '<S4>/FixPt Switch' */
  if (run_robot_DW.Output_DSTATE > run_robot_P.LimitedCounter_uplimit) {
    /* Sum: '<S3>/FixPt Sum1' incorporates:
     *  Constant: '<S4>/Constant'
     *  UnitDelay: '<S2>/Output'
     */
    run_robot_DW.Output_DSTATE = run_robot_P.Constant_Value;
  }

  /* End of Switch: '<S4>/FixPt Switch' */
  {                                    /* Sample time: [0.1s, 0.0s] */
  }

  /* Update absolute time for base rate */
  /* The "clockTick0" counts the number of times the code of this task has
   * been executed. The absolute time is the multiplication of "clockTick0"
   * and "Timing.stepSize0". Size of "clockTick0" ensures timer will not
   * overflow during the application lifespan selected.
   * Timer of this task consists of two 32 bit unsigned integers.
   * The two integers represent the low bits Timing.clockTick0 and the high bits
   * Timing.clockTickH0. When the low bit overflows to 0, the high bits increment.
   */
  if (!(++run_robot_M->Timing.clockTick0)) {
    ++run_robot_M->Timing.clockTickH0;
  }

  run_robot_M->Timing.taskTime0 = run_robot_M->Timing.clockTick0 *
    run_robot_M->Timing.stepSize0 + run_robot_M->Timing.clockTickH0 *
    run_robot_M->Timing.stepSize0 * 4294967296.0;
}

/* Model initialize function */
void run_robot_initialize(void)
{
  /* Registration code */

  /* initialize real-time model */
  (void) memset((void *)run_robot_M, 0,
                sizeof(RT_MODEL_run_robot_T));
  rtmSetTFinal(run_robot_M, 2.0);
  run_robot_M->Timing.stepSize0 = 0.1;

  /* External mode info */
  run_robot_M->Sizes.checksums[0] = (1933534420U);
  run_robot_M->Sizes.checksums[1] = (307034616U);
  run_robot_M->Sizes.checksums[2] = (2168453302U);
  run_robot_M->Sizes.checksums[3] = (534347378U);

  {
    static const sysRanDType rtAlwaysEnabled = SUBSYS_RAN_BC_ENABLE;
    static RTWExtModeInfo rt_ExtModeInfo;
    static const sysRanDType *systemRan[3];
    run_robot_M->extModeInfo = (&rt_ExtModeInfo);
    rteiSetSubSystemActiveVectorAddresses(&rt_ExtModeInfo, systemRan);
    systemRan[0] = &rtAlwaysEnabled;
    systemRan[1] = &rtAlwaysEnabled;
    systemRan[2] = &rtAlwaysEnabled;
    rteiSetModelMappingInfoPtr(run_robot_M->extModeInfo,
      &run_robot_M->SpecialInfo.mappingInfo);
    rteiSetChecksumsPtr(run_robot_M->extModeInfo, run_robot_M->Sizes.checksums);
    rteiSetTPtr(run_robot_M->extModeInfo, rtmGetTPtr(run_robot_M));
  }

  /* states (dwork) */
  (void) memset((void *)&run_robot_DW, 0,
                sizeof(DW_run_robot_T));

  /* Start for MATLABSystem: '<Root>/Standard Servo Write' */
  run_robot_DW.objisempty = true;
  run_robot_DW.obj.isInitialized = 1L;
  MW_servoAttach(0, 9);

  /* InitializeConditions for Sum: '<S3>/FixPt Sum1' incorporates:
   *  UnitDelay: '<S2>/Output'
   */
  run_robot_DW.Output_DSTATE = run_robot_P.Output_InitialCondition;
}

/* Model terminate function */
void run_robot_terminate(void)
{
  /* (no terminate code required) */
}
