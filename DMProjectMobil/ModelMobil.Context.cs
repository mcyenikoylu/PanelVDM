﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace DMProjectMobil
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    using System.Data.Entity.Core.Objects;
    using System.Linq;
    
    public partial class DMPortalEntities : DbContext
    {
        public DMPortalEntities()
            : base("name=DMPortalEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
    
        public virtual ObjectResult<OD_SP_006_01_CARI_EKSTRE_Result> OD_SP_006_01_CARI_EKSTRE(string cARI_KODU)
        {
            var cARI_KODUParameter = cARI_KODU != null ?
                new ObjectParameter("CARI_KODU", cARI_KODU) :
                new ObjectParameter("CARI_KODU", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<OD_SP_006_01_CARI_EKSTRE_Result>("OD_SP_006_01_CARI_EKSTRE", cARI_KODUParameter);
        }
    }
}