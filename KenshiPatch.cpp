void AdjustValueBasedOnFactors(float* valuePointer, float factor1, float factor2)
{
    const float modifier = 65.0f;
    const float newMaxLevel = 201.0f;

    if (*valuePointer > modifier)
    {
        factor2 = *valuePointer + (factor2 - modifier);
    }

    if (factor2 > newMaxLevel)
    {
        factor2 = newMaxLevel;
    }

    float normalizedDifference = (factor2 - *valuePointer) / factor2;
    float val = normalizedDifference * normalizedDifference;

    // NaN Check
    if (val == val && factor1 > 0.0f && val > 0.0f && factor1 <= 20.0f && val <= 20.0f)
    {
        *valuePointer += val * factor1;
    }
}
