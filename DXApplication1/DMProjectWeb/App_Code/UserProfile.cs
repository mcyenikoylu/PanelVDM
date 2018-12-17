using System.Web.Profile;
using System.Web.Security;

public class UserProfile : ProfileBase
{
    public static UserProfile GetUserProfile(string username)
    {
        return Create(username) as UserProfile;
    }
    public static UserProfile GetUserProfile()
    {
        return Create(Membership.GetUser().UserName) as UserProfile;
    }

    [SettingsAllowAnonymous(false)]
    public string BayiCariAdi
    {
        get { return base["BayiCariAdi"] as string; }
        set { base["BayiCariAdi"] = value; }
    }

    [SettingsAllowAnonymous(false)]
    public string BayiKodu
    {
        get { return base["BayiKodu"] as string; }
        set { base["BayiKodu"] = value; }
    }

    [SettingsAllowAnonymous(false)]
    public string BayiID
    {
        get { return base["BayiID"] as string; }
        set { base["BayiID"] = value; }
    }

    [SettingsAllowAnonymous(false)]
    public string Ismi
    {
        get { return base["Ismi"] as string; }
        set { base["Ismi"] = value; }
    }

    [SettingsAllowAnonymous(false)]
    public string Soyismi
    {
        get { return base["Soyismi"] as string; }
        set { base["Soyismi"] = value; }
    }

    [SettingsAllowAnonymous(false)]
    public string Onek
    {
        get { return base["Onek"] as string; }
        set { base["Onek"] = value; }
    }

    [SettingsAllowAnonymous(false)]
    public string DogumTarihi
    {
        get { return base["DogumTarihi"] as string; }
        set { base["DogumTarihi"] = value; }
    }

    [SettingsAllowAnonymous(false)]
    public string CepNumarasi
    {
        get { return base["CepNumarasi"] as string; }
        set { base["CepNumarasi"] = value; }
    }

    [SettingsAllowAnonymous(false)]
    public string DepartmanAdi
    {
        get { return base["DepartmanAdi"] as string; }
        set { base["DepartmanAdi"] = value; }
    }

    [SettingsAllowAnonymous(false)]
    public string Unvani
    {
        get { return base["Unvani"] as string; }
        set { base["Unvani"] = value; }
    }
    


}
