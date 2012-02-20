// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package org.energyos.espi.thirdparty.domain;

import java.lang.String;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import org.energyos.espi.thirdparty.domain.UsagePoint;
import org.energyos.espi.thirdparty.domain.UsagePointAsset;
import org.energyos.espi.thirdparty.domain.UsagePointDataOnDemand;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

privileged aspect UsagePointAssetDataOnDemand_Roo_DataOnDemand {
    
    declare @type: UsagePointAssetDataOnDemand: @Component;
    
    private Random UsagePointAssetDataOnDemand.rnd = new SecureRandom();
    
    private List<UsagePointAsset> UsagePointAssetDataOnDemand.data;
    
    @Autowired
    private UsagePointDataOnDemand UsagePointAssetDataOnDemand.usagePointDataOnDemand;
    
    public UsagePointAsset UsagePointAssetDataOnDemand.getNewTransientUsagePointAsset(int index) {
        UsagePointAsset obj = new UsagePointAsset();
        setName(obj, index);
        setUsagePoint(obj, index);
        return obj;
    }
    
    public void UsagePointAssetDataOnDemand.setName(UsagePointAsset obj, int index) {
        String name = "name_" + index;
        if (name.length() > 50) {
            name = name.substring(0, 50);
        }
        obj.setName(name);
    }
    
    public void UsagePointAssetDataOnDemand.setUsagePoint(UsagePointAsset obj, int index) {
        UsagePoint usagePoint = usagePointDataOnDemand.getRandomUsagePoint();
        obj.setUsagePoint(usagePoint);
    }
    
    public UsagePointAsset UsagePointAssetDataOnDemand.getSpecificUsagePointAsset(int index) {
        init();
        if (index < 0) index = 0;
        if (index > (data.size() - 1)) index = data.size() - 1;
        UsagePointAsset obj = data.get(index);
        return UsagePointAsset.findUsagePointAsset(obj.getId());
    }
    
    public UsagePointAsset UsagePointAssetDataOnDemand.getRandomUsagePointAsset() {
        init();
        UsagePointAsset obj = data.get(rnd.nextInt(data.size()));
        return UsagePointAsset.findUsagePointAsset(obj.getId());
    }
    
    public boolean UsagePointAssetDataOnDemand.modifyUsagePointAsset(UsagePointAsset obj) {
        return false;
    }
    
    public void UsagePointAssetDataOnDemand.init() {
        data = UsagePointAsset.findUsagePointAssetEntries(0, 10);
        if (data == null) throw new IllegalStateException("Find entries implementation for 'UsagePointAsset' illegally returned null");
        if (!data.isEmpty()) {
            return;
        }
        
        data = new ArrayList<org.energyos.espi.thirdparty.domain.UsagePointAsset>();
        for (int i = 0; i < 10; i++) {
            UsagePointAsset obj = getNewTransientUsagePointAsset(i);
            try {
                obj.persist();
            } catch (ConstraintViolationException e) {
                StringBuilder msg = new StringBuilder();
                for (Iterator<ConstraintViolation<?>> it = e.getConstraintViolations().iterator(); it.hasNext();) {
                    ConstraintViolation<?> cv = it.next();
                    msg.append("[").append(cv.getConstraintDescriptor()).append(":").append(cv.getMessage()).append("=").append(cv.getInvalidValue()).append("]");
                }
                throw new RuntimeException(msg.toString(), e);
            }
            obj.flush();
            data.add(obj);
        }
    }
    
}