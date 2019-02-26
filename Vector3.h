#pragma once
#define CHECK_VALID( _v ) 0
#define Assert( _exp ) ((void)0)
 
class Vector
{
public:
    float x, y, z;
    Vector(void);
    Vector(float X, float Y, float Z);
    void Init(float ix = 0.f, float iy = 0.f, float iz = 0.f);
    float operator[](int i) const;
    float& operator[](int i);
    inline void Zero();
    bool operator==(const Vector& v) const;
    bool operator!=(const Vector& v) const;
    Vector&   operator+=(const Vector &v);
    Vector&   operator-=(const Vector &v);
    Vector&   operator*=(const Vector &v);
    Vector&   operator*=(float s);
     Vector&   operator/=(const Vector &v);
     Vector&   operator/=(float s);
     Vector&   operator+=(float fl);
     Vector&   operator-=(float fl);
    inline float    Length() const;
     float LengthSqr(void) const
    {
        CHECK_VALID(*this);
        return (x*x + y*y + z*z);
    }
    bool IsZero(float tolerance = 0.01f) const
    {
        return (x > -tolerance && x < tolerance &&
            y > -tolerance && y < tolerance &&
            z > -tolerance && z < tolerance);
    }
    float   NormalizeInPlace();
     float DistToSqr(const Vector &vOther) const;
    float   Dot(const Vector& vOther) const;
    float   Length2D(void) const;
    float   Length2DSqr(void) const;
    Vector& operator=(const Vector &vOther);
    Vector  operator+(const Vector& v) const;
    Vector  operator-(const Vector& v) const;
    Vector  operator*(const Vector& v) const;
    Vector  operator/(const Vector& v) const;
    Vector  operator*(float fl) const;
    Vector  operator/(float fl) const;
};
inline void Vector::Init(float ix, float iy, float iz)
{
    x = ix; y = iy; z = iz;
    CHECK_VALID(*this);
}
inline Vector::Vector(float X, float Y, float Z)
{
    x = X; y = Y; z = Z;
    CHECK_VALID(*this);
}
inline Vector::Vector(void)
{
}
inline void Vector::Zero()
{
    x = y = z = 0.f;
}
inline void VectorClear(Vector& a)
{
    a.x = a.y = a.z = 0.f;
}
inline Vector& Vector::operator=(const Vector &vOther)
{
    CHECK_VALID(vOther);
    x = vOther.x; y = vOther.y; z = vOther.z;
    return *this;
}
inline float& Vector::operator[](int i)
{
    Assert((i >= 0) && (i < 3));
    return ((float*)this)[i];
}
inline float Vector::operator[](int i) const
{
    Assert((i >= 0) && (i < 3));
    return ((float*)this)[i];
}
inline bool Vector::operator==(const Vector& src) const
{
    CHECK_VALID(src);
    CHECK_VALID(*this);
    return (src.x == x) && (src.y == y) && (src.z == z);
}
inline bool Vector::operator!=(const Vector& src) const
{
    CHECK_VALID(src);
    CHECK_VALID(*this);
    return (src.x != x) || (src.y != y) || (src.z != z);
}
 void VectorCopy(const Vector& src, Vector& dst)
{
    CHECK_VALID(src);
    dst.x = src.x;
    dst.y = src.y;
    dst.z = src.z;
}
  Vector& Vector::operator+=(const Vector& v)
{
    CHECK_VALID(*this);
    CHECK_VALID(v);
    x += v.x; y += v.y; z += v.z;
    return *this;
}
  Vector& Vector::operator-=(const Vector& v)
{
    CHECK_VALID(*this);
    CHECK_VALID(v);
    x -= v.x; y -= v.y; z -= v.z;
    return *this;
}
  Vector& Vector::operator*=(float fl)
{
    x *= fl;
    y *= fl;
    z *= fl;
    CHECK_VALID(*this);
    return *this;
}
  Vector& Vector::operator*=(const Vector& v)
{
    CHECK_VALID(v);
    x *= v.x;
    y *= v.y;
    z *= v.z;
    CHECK_VALID(*this);
    return *this;
}
 
 Vector&   Vector::operator+=(float fl)
{
    x += fl;
    y += fl;
    z += fl;
    CHECK_VALID(*this);
    return *this;
}
 
 Vector&   Vector::operator-=(float fl)
{
    x -= fl;
    y -= fl;
    z -= fl;
    CHECK_VALID(*this);
    return *this;
}
 
  Vector& Vector::operator/=(float fl)
{
    Assert(fl != 0.f);
    float oofl = 1.0f / fl;
    x *= oofl;
    y *= oofl;
    z *= oofl;
    CHECK_VALID(*this);
    return *this;
}
 
  Vector& Vector::operator/=(const Vector& v)
{
    CHECK_VALID(v);
    Assert(v.x != 0.f && v.y != 0.f && v.z != 0.f);
    x /= v.x;
    y /= v.y;
    z /= v.z;
    CHECK_VALID(*this);
    return *this;
}
 
inline float Vector::Length(void) const
{
    CHECK_VALID(*this);
 
    float root = 0.f;
 
    float sqsr = x*x + y*y + z*z;
 
    
 
    return root;
}
 
inline float Vector::Length2D(void) const
{
    CHECK_VALID(*this);
 
    float root = 0.f;
 
    float sqst = x*x + y*y;
 
    
 
    return root;
}
 
inline float Vector::Length2DSqr(void) const
{
    return (x*x + y*y);
}
 
inline Vector CrossProduct(const Vector& a, const Vector& b)
{
    return Vector(a.y*b.z - a.z*b.y, a.z*b.x - a.x*b.z, a.x*b.y - a.y*b.x);
}
 
float Vector::DistToSqr(const Vector &vOther) const
{
    Vector delta;
 
    delta.x = x - vOther.x;
    delta.y = y - vOther.y;
    delta.z = z - vOther.z;
 
    return delta.LengthSqr();
}
 
inline float Vector::NormalizeInPlace()
{
    Vector& v = *this;
 
    float iradius = 1.f / (this->Length() + 1.192092896e-07F); //FLT_EPSILON
 
    v.x *= iradius;
    v.y *= iradius;
    v.z *= iradius;
}
 
inline Vector Vector::operator+(const Vector& v) const
{
    Vector res;
    res.x = x + v.x;
    res.y = y + v.y;
    res.z = z + v.z;
    return res;
}
 
inline Vector Vector::operator-(const Vector& v) const
{
    Vector res;
    res.x = x - v.x;
    res.y = y - v.y;
    res.z = z - v.z;
    return res;
}
 
inline Vector Vector::operator*(float fl) const
{
    Vector res;
    res.x = x * fl;
    res.y = y * fl;
    res.z = z * fl;
    return res;
}
 
inline Vector Vector::operator*(const Vector& v) const
{
    Vector res;
    res.x = x * v.x;
    res.y = y * v.y;
    res.z = z * v.z;
    return res;
}
 
inline Vector Vector::operator/(float fl) const
{
    Vector res;
    res.x = x / fl;
    res.y = y / fl;
    res.z = z / fl;
    return res;
}
 
inline Vector Vector::operator/(const Vector& v) const
{
    Vector res;
    res.x = x / v.x;
    res.y = y / v.y;
    res.z = z / v.z;
    return res;
}
inline float Vector::Dot(const Vector& vOther) const
{
    const Vector& a = *this;
 
    return(a.x*vOther.x + a.y*vOther.y + a.z*vOther.z);
}